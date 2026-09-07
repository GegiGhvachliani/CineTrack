//
//  ActorDetailsViewModel.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import Observation

import ActorDetailsDomain
import SharedCore

@MainActor
public protocol ActorDetailsViewModelProtocol: AnyObject {
    var actor: ActorDetails? { get }
    var credits: [ActorCredit] { get }
    var images: [ActorImage] { get }
    var externalLinks: ActorExternalLinks? { get }
    var news: [News] { get }
    var isFavourite: Bool { get }
    var isFavouriteUpdating: Bool { get }
    var isLoading: Bool { get }
    var error: Error? { get }

    func load() async
    func retry() async
    func didTapCredit(_ credit: ActorCredit)
    func didTapNews(_ news: News)
    func didTapShowAllPhotos()
    func didTapMiniBiography()
    func didTapExternalURL(_ url: URL)
    func toggleFavourite() async
}

@MainActor
@Observable
public final class ActorDetailsViewModel: ActorDetailsViewModelProtocol {
    public private(set) var actor: ActorDetails?
    public private(set) var credits: [ActorCredit] = []
    public private(set) var images: [ActorImage] = []
    public private(set) var externalLinks: ActorExternalLinks?
    public private(set) var news: [News] = []
    public private(set) var favouritedActorIDs = Set<Int>()

    public private(set) var isLoading = false
    public private(set) var isCreditsLoading = false
    public private(set) var isImagesLoading = false
    public private(set) var isExternalLinksLoading = false
    public private(set) var isNewsLoading = false
    public private(set) var error: Error?
    public private(set) var sectionErrors: [ActorDetailsSection: Error] = [:]

    public let actorID: Int

    public var onMovieDetails: ((Movie) -> Void)?
    public var onNewsDetails: ((News) -> Void)?
    public var onShowAllPhotos: (([ActorImage], String) -> Void)?
    public var onShowMiniBiography: ((ActorDetails) -> Void)?
    public var onOpenURL: ((URL) -> Void)?

    public var featuredCredits: [ActorCredit] {
        Array(
            filmography
                .filter {
                    $0.backdropURL != nil ||
                    $0.posterURL != nil
                }
                .prefix(12)
        )
    }

    public var filmography: [ActorCredit] {
        var seenMovieIDs = Set<Int>()

        return credits.filter {
            seenMovieIDs.insert($0.id).inserted
        }
    }

    public var personalLinks: [ActorExternalLink] {
        var links = externalLinks?.links ?? []

        if let homepage = actor?.homepage,
           let url = URL(string: homepage) {
            links.insert(
                ActorExternalLink(
                    id: "homepage",
                    title: "Website",
                    url: url
                ),
                at: 0
            )
        }

        return links
    }

    public var photoPreview: [ActorImage] {
        Array(images.prefix(6))
    }

    public var isFavourite: Bool {
        favouritedActorIDs.contains(actorID)
    }

    public var isFavouriteUpdating: Bool {
        pendingFavouriteIDs.contains(actorID)
    }

    private var hasLoadedInitialContent = false

    private let fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol
    private let fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol
    private let fetchActorImagesUseCase: FetchActorImagesUseCaseProtocol
    private let fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol
    private let fetchActorNewsUseCase: FetchActorNewsUseCaseProtocol
    private let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol
    private let addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol
    private let removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol
    private var pendingFavouriteIDs = Set<Int>()

    public init(
        actorID: Int,
        fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol,
        fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol,
        fetchActorImagesUseCase: FetchActorImagesUseCaseProtocol,
        fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol,
        fetchActorNewsUseCase: FetchActorNewsUseCaseProtocol,
        fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol,
        addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol,
        removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol
    ) {
        self.actorID = actorID
        self.fetchActorDetailsUseCase = fetchActorDetailsUseCase
        self.fetchActorCreditsUseCase = fetchActorCreditsUseCase
        self.fetchActorImagesUseCase = fetchActorImagesUseCase
        self.fetchActorExternalLinksUseCase = fetchActorExternalLinksUseCase
        self.fetchActorNewsUseCase = fetchActorNewsUseCase
        self.fetchFavouritedActorsUseCase = fetchFavouritedActorsUseCase
        self.addFavouritedActorUseCase = addFavouritedActorUseCase
        self.removeFavouritedActorUseCase = removeFavouritedActorUseCase
    }

    public func load() async {
        await load(force: false)
    }

    public func retry() async {
        await load(force: true)
    }

    private func load(
        force: Bool
    ) async {
        guard !isLoading, force || !hasLoadedInitialContent else {
            return
        }

        isLoading = true
        error = nil
        sectionErrors = [:]

        defer {
            isLoading = false
            hasLoadedInitialContent = true
        }

        do {
            actor = try await fetchActorDetailsUseCase.execute(
                actorID: actorID
            )
        } catch {
            self.error = error
            return
        }

        guard let actor else {
            return
        }

        async let creditsTask: Void = loadCredits()
        async let imagesTask: Void = loadImages()
        async let linksTask: Void = loadExternalLinks()
        async let newsTask: Void = loadNews(actorName: actor.name)
        async let favouritesTask: Void = loadFavourites()

        await creditsTask
        await imagesTask
        await linksTask
        await newsTask
        await favouritesTask
    }

    public func didTapCredit(
        _ credit: ActorCredit
    ) {
        onMovieDetails?(
            Movie(
                id: credit.id,
                title: credit.title,
                overview: credit.overview,
                posterPath: credit.posterPath,
                backdropPath: credit.backdropPath,
                releaseDate: credit.releaseDate,
                voteAverage: credit.voteAverage,
                voteCount: credit.voteCount
            )
        )
    }

    public func didTapNews(
        _ news: News
    ) {
        onNewsDetails?(news)
    }

    public func didTapShowAllPhotos() {
        guard let actor else {
            return
        }

        onShowAllPhotos?(
            images,
            actor.name
        )
    }

    public func didTapMiniBiography() {
        guard let actor else {
            return
        }
        onShowMiniBiography?(actor)
    }

    public func didTapExternalURL(
        _ url: URL
    ) {
        onOpenURL?(url)
    }

    public func toggleFavourite() async {
        guard let actor, pendingFavouriteIDs.insert(actor.id).inserted else {
            return
        }

        defer {
            pendingFavouriteIDs.remove(actor.id)
        }

        let sharedActor = Actor(
            id: actor.id,
            name: actor.name,
            birthday: actor.birthday,
            profilePath: actor.profilePath
        )
        let wasFavourite = favouritedActorIDs.contains(actor.id)

        if wasFavourite {
            favouritedActorIDs.remove(actor.id)
        } else {
            favouritedActorIDs.insert(actor.id)
        }

        do {
            if wasFavourite {
                try await removeFavouritedActorUseCase.execute(sharedActor)
            } else {
                try await addFavouritedActorUseCase.execute(sharedActor)
            }
        } catch {
            if wasFavourite {
                favouritedActorIDs.insert(actor.id)
            } else {
                favouritedActorIDs.remove(actor.id)
            }
            sectionErrors[.favourites] = error
        }
    }

    private func loadFavourites() async {
        do {
            favouritedActorIDs = Set(
                try await fetchFavouritedActorsUseCase.execute().map(\.id)
            )
        } catch {
            sectionErrors[.favourites] = error
        }
    }

    private func loadCredits() async {
        isCreditsLoading = true

        defer {
            isCreditsLoading = false
        }

        do {
            credits = try await fetchActorCreditsUseCase.execute(
                actorID: actorID
            )
        } catch {
            sectionErrors[.filmography] = error
        }
    }

    private func loadImages() async {
        isImagesLoading = true

        defer {
            isImagesLoading = false
        }

        do {
            images = try await fetchActorImagesUseCase.execute(
                actorID: actorID
            )
        } catch {
            sectionErrors[.photos] = error
        }
    }

    private func loadExternalLinks() async {
        isExternalLinksLoading = true

        defer {
            isExternalLinksLoading = false
        }

        do {
            externalLinks = try await fetchActorExternalLinksUseCase.execute(
                actorID: actorID
            )
        } catch {
            sectionErrors[.personalDetails] = error
        }
    }

    private func loadNews(
        actorName: String
    ) async {
        isNewsLoading = true

        defer {
            isNewsLoading = false
        }

        do {
            news = try await fetchActorNewsUseCase.execute(
                actorName: actorName
            )
        } catch {
            sectionErrors[.news] = error
        }
    }
}

public enum ActorDetailsSection: Hashable, Sendable {
    case favourites
    case filmography
    case photos
    case personalDetails
    case news
}
