//
//  ActorDetailsFactory.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import UIKit
import SwiftUI

import ActorDetailsData
import ActorDetailsDomain
import ActorDetailsPresentation
import ActorDetailsPresentationAPI
import SharedCore
import SharedNetworking
import SharedAuth
import SharedStorage
import TMDBData
import NewsData
import ActorMediaData
import ActorMediaDomain
import ActorVideosData
import ActorVideosDomain
import LibraryData
import LibraryDomain

@MainActor
public struct ActorDetailsFactory: ActorDetailsFactoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let tmdbConfiguration: TMDBConfiguration
    private let newsConfiguration: NewsConfiguration
    private let firestore: RemoteDocumentStore
    private let userSession: UserSession

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        tmdbConfiguration: TMDBConfiguration,
        newsConfiguration: NewsConfiguration,
        firestore: RemoteDocumentStore,
        userSession: UserSession
    ) {
        self.apiClient = apiClient
        self.tmdbConfiguration = tmdbConfiguration
        self.newsConfiguration = newsConfiguration
        self.firestore = firestore
        self.userSession = userSession
    }

    public func makeActorDetailsCoordinator(
        actorID: Int,
        navigationController: UINavigationController,
        router: ActorDetailsRoutingProtocol
    ) -> ActorDetailsCoordinatorProtocol {
        ActorDetailsCoordinator(
            actorID: actorID,
            navigationController: navigationController,
            factory: self,
            router: router
        )
    }

    public func makeActorDetailsViewController(
        actorID: Int,
        onMovieDetails: @escaping (Movie) -> Void,
        onNewsDetails: @escaping (News) -> Void,
        onShowMiniBiography: @escaping (ActorDetails) -> Void,
        onShowSeeAll: @escaping (SeeAllContent) -> Void,
        onShowVideos: @escaping (VideoPlaylistContext) -> Void
    ) -> UIViewController {
        let repository = ActorDetailsRepository(
            apiClient: apiClient,
            configuration: tmdbConfiguration,
            newsConfiguration: newsConfiguration
        )
        let favouriteRepository = FavouriteRepository(
            firestore: firestore,
            userSession: userSession
        )
        let watchlistRepository = LibraryData.WatchlistRepository(
            firestore: firestore,
            userSession: userSession
        )
        let recentlyViewedRepository = RecentlyViewedRepository(
            firestore: firestore,
            userSession: userSession
        )
        let viewModel = ActorDetailsViewModel(
            actorID: actorID,
            addRecentlyViewedActorUseCase: AddRecentlyViewedActorUseCase(repository: recentlyViewedRepository),
            fetchActorDetailsUseCase: FetchActorDetailsUseCase(repository: repository),
            fetchActorCreditsUseCase: FetchActorCreditsUseCase(repository: repository),
            fetchActorMediaUseCase: FetchActorMediaUseCase(
                repository: WikimediaActorMediaRepository(apiClient: apiClient)
            ),
            fetchActorVideosUseCase: FetchActorVideosUseCase(
                repository: ActorVideosRepository(
                    apiClient: apiClient,
                    configuration: tmdbConfiguration
                )
            ),
            fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCase(repository: repository),
            fetchActorNewsUseCase: FetchActorNewsUseCase(repository: repository),
            fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCase(repository: favouriteRepository),
            addFavouritedActorUseCase: AddFavouritedActorUseCase(repository: favouriteRepository),
            removeFavouritedActorUseCase: RemoveFavouritedActorUseCase(repository: favouriteRepository),
            fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCase(repository: watchlistRepository),
            addWatchlistedMovieUseCase: AddWatchlistedMovieUseCase(repository: watchlistRepository),
            removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCase(repository: watchlistRepository)
        )
        viewModel.onMovieDetails = onMovieDetails
        viewModel.onNewsDetails = onNewsDetails
        viewModel.onShowMiniBiography = onShowMiniBiography
        viewModel.onShowSeeAll = onShowSeeAll
        viewModel.onShowVideos = onShowVideos
        viewModel.onOpenURL = { url in
            UIApplication.shared.open(url)
        }

        return UIHostingController(rootView: ActorDetailsView(viewModel: viewModel))
    }

    public func makeMiniBiographyViewController(actor: ActorDetails) -> UIViewController {
        UIHostingController(rootView: MiniBiographyView(actor: actor))
    }
}
