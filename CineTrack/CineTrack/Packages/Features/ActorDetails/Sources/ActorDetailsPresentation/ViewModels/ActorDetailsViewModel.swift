//
//  ActorDetailsViewModel.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import Observation

import ActorDetailsDomain
import ActorMediaDomain
import SharedCore

@MainActor
public protocol ActorDetailsViewModelProtocol: AnyObject {
    var actor: ActorDetails? { get }
    var credits: [ActorCredit] { get }
    var externalLinks: ActorExternalLinks? { get }
    var news: [News] { get }
    var isFavourite: Bool { get }
    var isFavouriteUpdating: Bool { get }
    func isWatchlisted(_ credit: ActorCredit) -> Bool
    var isLoading: Bool { get }
    var error: Error? { get }

    func load() async
    func retry() async
    func didTapCredit(_ credit: ActorCredit)
    func didTapNews(_ news: News)
    func didTapMiniBiography()
    func didTapSeeAllFilmography()
    func didTapExternalURL(_ url: URL)
    func toggleFavourite() async
    func toggleWatchlist(for credit: ActorCredit) async
}

@MainActor
@Observable
public final class ActorDetailsViewModel: ActorDetailsViewModelProtocol {
    public private(set) var actor: ActorDetails?
    public private(set) var credits: [ActorCredit] = []
    public private(set) var mediaImages: [ActorMediaImage] = []
    public private(set) var isMediaLoading = false
    public private(set) var hasMoreMedia = true
    private var mediaContinuation: String?
    public private(set) var externalLinks: ActorExternalLinks?
    public private(set) var news: [News] = []
    public private(set) var favouritedActorIDs = Set<Int>()
    public internal(set) var watchlistedMovieIDs = Set<Int>()

    public private(set) var isLoading = false
    public private(set) var isCreditsLoading = false
    public private(set) var isExternalLinksLoading = false
    public private(set) var isNewsLoading = false
    public private(set) var error: Error?
    public internal(set) var sectionErrors: [ActorDetailsSection: Error] = [:]

    public let actorID: Int

    public var onMovieDetails: ((Movie) -> Void)?
    public var onNewsDetails: ((News) -> Void)?
    public var onShowMiniBiography: ((ActorDetails) -> Void)?
    public var onShowAllFilmography: (() -> Void)?
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

    public var isFavourite: Bool {
        favouritedActorIDs.contains(actorID)
    }

    public var isFavouriteUpdating: Bool {
        pendingFavouriteIDs.contains(actorID)
    }

    private var hasLoadedInitialContent = false

    private let fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol
    private let fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol
    private let fetchActorMediaUseCase: FetchActorMediaUseCaseProtocol
    private let fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol
    private let fetchActorNewsUseCase: FetchActorNewsUseCaseProtocol
    private let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol
    private let addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol
    private let removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol
    let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol
    let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol
    let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol
    private var pendingFavouriteIDs = Set<Int>()
    var pendingWatchlistIDs = Set<Int>()

    public init(
        actorID: Int,
        fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol,
        fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol,
        fetchActorMediaUseCase: FetchActorMediaUseCaseProtocol,
        fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol,
        fetchActorNewsUseCase: FetchActorNewsUseCaseProtocol,
        fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol,
        addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol,
        removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol,
        fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol,
        addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol,
        removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol
    ) {
        self.actorID = actorID
        self.fetchActorDetailsUseCase = fetchActorDetailsUseCase
        self.fetchActorCreditsUseCase = fetchActorCreditsUseCase
        self.fetchActorMediaUseCase = fetchActorMediaUseCase
        self.fetchActorExternalLinksUseCase = fetchActorExternalLinksUseCase
        self.fetchActorNewsUseCase = fetchActorNewsUseCase
        self.fetchFavouritedActorsUseCase = fetchFavouritedActorsUseCase
        self.addFavouritedActorUseCase = addFavouritedActorUseCase
        self.removeFavouritedActorUseCase = removeFavouritedActorUseCase
        self.fetchWatchlistedMoviesUseCase = fetchWatchlistedMoviesUseCase
        self.addWatchlistedMovieUseCase = addWatchlistedMovieUseCase
        self.removeWatchlistedMovieUseCase = removeWatchlistedMovieUseCase
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
        async let mediaTask: Void = loadNextMediaPage(actorName: actor.name)
        async let linksTask: Void = loadExternalLinks()
        async let newsTask: Void = loadNews(actorName: actor.name)
        async let favouritesTask: Void = loadFavourites()
        async let watchlistTask: Void = loadWatchlist()

        await creditsTask
        await mediaTask
        await linksTask
        await newsTask
        await favouritesTask
        await watchlistTask
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

    public func didTapMiniBiography() {
        guard let actor else {
            return
        }
        onShowMiniBiography?(actor)
    }

    public func didTapSeeAllFilmography() {
        onShowAllFilmography?()
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

    public func loadNextMediaPage() async {
        guard let actor else { return }
        await loadNextMediaPage(actorName: actor.name)
    }

    private func loadNextMediaPage(actorName: String) async {
        guard !isMediaLoading, hasMoreMedia else { return }
        isMediaLoading = true
        defer { isMediaLoading = false }
        do {
            let page = try await fetchActorMediaUseCase.execute(actorName: actorName, continuation: mediaContinuation)
            mediaImages.append(contentsOf: page.images)
            mediaContinuation = page.nextToken
            hasMoreMedia = page.nextToken != nil
        }
        catch { sectionErrors[.photos] = error }
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
