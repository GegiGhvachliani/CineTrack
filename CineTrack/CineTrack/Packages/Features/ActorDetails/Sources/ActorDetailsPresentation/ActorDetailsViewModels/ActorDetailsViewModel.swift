//
//  ActorDetailsViewModel.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import LibraryDomain
import Observation

import ActorDetailsDomain
import SharedCore

@Observable
@MainActor
public final class ActorDetailsViewModel: ActorDetailsViewModelProtocol {

    // MARK: - Content

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

    // MARK: - Actions

    public var onMovieDetails: ((Movie) -> Void)?
    public var onNewsDetails: ((News) -> Void)?
    public var onShowMiniBiography: ((ActorDetails) -> Void)?
    public var onShowSeeAll: ((SeeAllContent) -> Void)?
    public var onShowVideos: ((VideoPlaylistContext) -> Void)?
    public var onOpenURL: ((URL) -> Void)?

    public var featuredCredits: [ActorCredit] {
        Array(
            filmography
                .filter {
                    $0.backdropURL != nil || $0.posterURL != nil
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
                    title: ActorDetailsStrings.Content.website,
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

    // MARK: - Dependencies (UseCases)

    let addRecentlyViewedActorUseCase: AddRecentlyViewedActorUseCaseProtocol
    let fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol
    let fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol
    let fetchActorMediaUseCase: FetchActorMediaUseCaseProtocol
    let fetchActorVideosUseCase: FetchActorVideosUseCaseProtocol
    let fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol
    let fetchActorNewsUseCase: FetchActorNewsUseCaseProtocol
    let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol
    internal let addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol
    internal let removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol
    let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol
    let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol
    let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol
    internal var pendingFavouriteIDs = Set<Int>()
    var pendingWatchlistIDs = Set<Int>()

    // MARK: - Initialization

    public init(
        actorID: Int,
        addRecentlyViewedActorUseCase: AddRecentlyViewedActorUseCaseProtocol,
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
        self.addRecentlyViewedActorUseCase = addRecentlyViewedActorUseCase
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

}
