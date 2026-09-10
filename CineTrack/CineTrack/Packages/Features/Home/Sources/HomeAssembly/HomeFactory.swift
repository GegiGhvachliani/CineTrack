//
//  HomeFactory.swift
//  Home
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit
import LibraryData
import LibraryDomain
import SwiftUI

import HomeDomain
import HomeData
import HomePresentation
import HomePresentationAPI

import SharedAuth
import SharedNetworking
import SharedStorage

import TMDBData

import NewsData

@MainActor
public struct HomeFactory: HomeFactoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let configuration: TMDBConfiguration
    private let newsConfiguration: NewsConfiguration
    private let firestore: RemoteDocumentStore
    private let userSession: UserSession

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        newsConfiguration: NewsConfiguration,
        firestore: RemoteDocumentStore,
        userSession: UserSession
    ) {
        self.apiClient = apiClient
        self.configuration = configuration
        self.newsConfiguration = newsConfiguration
        self.firestore = firestore
        self.userSession = userSession
    }

    public func makeHomeViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController {

        // MARK: - Repository

        let repository = HomeRepository(
            apiClient: apiClient,
            configuration: configuration,
            newsConfiguration: newsConfiguration
        )

        // MARK: - Recently Viewed Repository

        let recentlyViewedRepository = RecentlyViewedRepository(
            firestore: firestore,
            userSession: userSession
        )

        // MARK: - Watchlist Repository

        let watchlistRepository = WatchlistRepository(
            firestore: firestore,
            userSession: userSession
        )

        // MARK: - Favourite Repository

        let favouriteRepository = FavouriteRepository(
            firestore: firestore,
            userSession: userSession
        )

        // MARK: - Use Cases

        let fetchTrendingUseCase = FetchTrendingUseCase(repository: repository)

        let fetchPopularUseCase = FetchPopularUseCase(repository: repository)

        let fetchFanFavouritesUseCase = FetchFanFavouritesUseCase(repository: repository)

        let fetchTop10MoviesUseCase = FetchTop10MoviesUseCase(repository: repository)

        let fetchNowPlayingUseCase = FetchNowPlayingUseCase(repository: repository)

        let fetchUpcomingUseCase = FetchUpcomingUseCase(repository: repository)

        let fetchMovieVideosUseCase = FetchMovieVideosUseCase(repository: repository)

        let fetchBornTodayActorsUseCase = FetchBornTodayActorsUseCase(repository: repository)

        let fetchMostPopularActorsUseCase = FetchMostPopularActorsUseCase(repository: repository)

        let fetchNewsUseCase = FetchNewsUseCase(repository: repository)

        // MARK: - Recently Viewed Use Cases

        let fetchRecentlyViewedMoviesUseCase = FetchRecentlyViewedMoviesUseCase(repository: recentlyViewedRepository)

        let fetchRecentlyViewedActorsUseCase = FetchRecentlyViewedActorsUseCase(repository: recentlyViewedRepository)

        let clearRecentlyViewedUseCase = ClearRecentlyViewedUseCase(repository: recentlyViewedRepository)

        // MARK: - Watchlist Use Cases

        let fetchWatchlistedMoviesUseCase = FetchWatchlistedMoviesUseCase(repository: watchlistRepository)

        let addWatchlistedMovieUseCase = AddWatchlistedMovieUseCase(repository: watchlistRepository)

        let removeWatchlistedMovieUseCase = RemoveWatchlistedMovieUseCase(repository: watchlistRepository)

        // MARK: - Favourite Use Cases

        let fetchFavouritedActorsUseCase = FetchFavouritedActorsUseCase(repository: favouriteRepository)

        let addFavouritedActorUseCase = AddFavouritedActorUseCase(repository: favouriteRepository)

        let removeFavouritedActorUseCase = RemoveFavouritedActorUseCase(repository: favouriteRepository)

        // MARK: - Favourite Actor Movies

        let fetchActorMoviesUseCase = FetchActorMoviesUseCase(
            repository: repository
        )

        // MARK: - ViewModel

        let viewModel = HomeViewModel(
            // movies
            fetchTrendingUseCase: fetchTrendingUseCase,
            fetchPopularUseCase: fetchPopularUseCase,
            fetchTop10MoviesUseCase: fetchTop10MoviesUseCase,
            fetchFanFavouritesUseCase: fetchFanFavouritesUseCase,
            fetchNowPlayingUseCase: fetchNowPlayingUseCase,
            fetchUpcomingUseCase: fetchUpcomingUseCase,
            fetchMovieVideosUseCase: fetchMovieVideosUseCase,
            fetchBornTodayActorsUseCase: fetchBornTodayActorsUseCase,
            fetchMostPopularActorsUseCase: fetchMostPopularActorsUseCase,
            fetchNewsUseCase: fetchNewsUseCase,
            // recentlyViewed
            fetchRecentlyViewedMoviesUseCase: fetchRecentlyViewedMoviesUseCase,
            fetchRecentlyViewedActorsUseCase: fetchRecentlyViewedActorsUseCase,
            clearRecentlyViewedUseCase: clearRecentlyViewedUseCase,
            // watchlist
            fetchWatchlistedMoviesUseCase: fetchWatchlistedMoviesUseCase,
            addWatchlistedMovieUseCase: addWatchlistedMovieUseCase,
            removeWatchlistedMovieUseCase: removeWatchlistedMovieUseCase,
            // favourites
            fetchFavouritedActorsUseCase: fetchFavouritedActorsUseCase,
            addFavouritedActorUseCase: addFavouritedActorUseCase,
            removeFavouritedActorUseCase: removeFavouritedActorUseCase,
            // favourite actor movies
            fetchActorMoviesUseCase: fetchActorMoviesUseCase,
        )

        // MARK: - SwiftUI View

        let homeView = HomeView(viewModel: viewModel)

        viewModel.onSearch = { [weak coordinator] in
            coordinator?.showSearch()
        }

        viewModel.onMovieDetails = { [weak coordinator] movie in
            coordinator?.showMovieDetails(movie: movie)
        }

        viewModel.onVideos = { [weak coordinator] item in
            coordinator?.showVideos(item: item)
        }

        viewModel.onActorDetails = { [weak coordinator] actorID in
            coordinator?.showActorDetails(actorID: actorID)
        }

        viewModel.onNewsDetails = { [weak coordinator] news in
            coordinator?.showNewsDetail(news: news)
        }

        viewModel.onSeeAll = { [weak coordinator] content in
            coordinator?.showSeeAll(content: content)
        }

        // MARK: - Hosting Controller

        let hostingController = UIHostingController(
            rootView: homeView
        )

        return hostingController

    }

    public func makeHomeCoordinator(
        navigationController: UINavigationController,
        router: HomeRoutingProtocol
    ) -> HomeCoordinatorProtocol {
        HomeCoordinator(
            navigationController: navigationController,
            factory: self,
            router: router
        )
    }
}
