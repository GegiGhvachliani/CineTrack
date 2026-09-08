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
import ActorVideosDomain
import SharedCore

@MainActor
public protocol ActorDetailsViewModelProtocol: AnyObject {
    var actor: ActorDetails? { get }
    var credits: [ActorCredit] { get }
    var actorVideos: [ActorVideo] { get }
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
    public internal(set) var actor: ActorDetails?
    public internal(set) var credits: [ActorCredit] = []
    public internal(set) var mediaImages: [ActorMediaImage] = []
    public internal(set) var actorVideos: [ActorVideo] = []
    public internal(set) var isMediaLoading = false
    public internal(set) var isVideosLoading = false
    public internal(set) var hasMoreMedia = true
    var mediaContinuation: String?
    public internal(set) var externalLinks: ActorExternalLinks?
    public internal(set) var news: [News] = []
    public internal(set) var favouritedActorIDs = Set<Int>()
    public internal(set) var watchlistedMovieIDs = Set<Int>()

    public internal(set) var isLoading = false
    public internal(set) var isCreditsLoading = false
    public internal(set) var isExternalLinksLoading = false
    public internal(set) var isNewsLoading = false
    public internal(set) var error: Error?
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

    var hasLoadedInitialContent = false

    let fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol
    let fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol
    let fetchActorMediaUseCase: FetchActorMediaUseCaseProtocol
    let fetchActorVideosUseCase: FetchActorVideosUseCaseProtocol
    let fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol
    let fetchActorNewsUseCase: FetchActorNewsUseCaseProtocol
    let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol
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
        fetchActorVideosUseCase: FetchActorVideosUseCaseProtocol,
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
        self.fetchActorVideosUseCase = fetchActorVideosUseCase
        self.fetchActorExternalLinksUseCase = fetchActorExternalLinksUseCase
        self.fetchActorNewsUseCase = fetchActorNewsUseCase
        self.fetchFavouritedActorsUseCase = fetchFavouritedActorsUseCase
        self.addFavouritedActorUseCase = addFavouritedActorUseCase
        self.removeFavouritedActorUseCase = removeFavouritedActorUseCase
        self.fetchWatchlistedMoviesUseCase = fetchWatchlistedMoviesUseCase
        self.addWatchlistedMovieUseCase = addWatchlistedMovieUseCase
        self.removeWatchlistedMovieUseCase = removeWatchlistedMovieUseCase
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

}

public enum ActorDetailsSection: Hashable, Sendable {
    case favourites
    case filmography
    case videos
    case photos
    case personalDetails
    case news
}
