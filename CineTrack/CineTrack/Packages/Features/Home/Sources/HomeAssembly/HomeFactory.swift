//
//  HomeFactory.swift
//  Home
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit
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

    public init() {}

    public func makeHomeViewController() -> UIViewController {
        
        // MARK: - API Client

        let apiClient = URLSessionAPIClient()

        // MARK: - TMDB Configuration

        let configuration = TMDBConfiguration(
            baseURL: URL(
                string: "https://api.themoviedb.org"
            )!,
            accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NWEyZmRkNjQyY2FmOTMzYTVjMzk5N2VkY2VjYTRjNSIsIm5iZiI6MTc2Mzk4OTQxNS42MDA5OTk4LCJzdWIiOiI2OTI0NTdhN2EwYzRiMWIxMzIxODc1ZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ZfESC0ZJHYqzbSE2xCYRjfOSwiacjs7sYl-_qvgDbc4"
        )

        // MARK: - News Configuration

        let newsConfiguration = NewsConfiguration(
            baseURL: URL(
                string: "https://newsapi.org"
            )!,
            apiKey: Bundle.main.object(
                forInfoDictionaryKey: "NEWS_API_KEY"
            ) as? String ?? ""
        )

        // MARK: - Repository

        let repository = HomeRepository(
            apiClient: apiClient,
            configuration: configuration,
            newsConfiguration: newsConfiguration
        )
        
        // MARK: - Recently Viewed Repository

        let firestore =
            FirestoreClient()

        let userSession =
            FirebaseUserSession()

        let recentlyViewedRepository =
            RecentlyViewedRepository(
                firestore: firestore,
                userSession: userSession
            )
        
        // MARK: - Use Cases

        let fetchTrendingUseCase = FetchTrendingUseCase(
            repository: repository
        )

        let fetchPopularUseCase = FetchPopularUseCase(
            repository: repository
        )

        let fetchFanFavouritesUseCase = FetchFanFavouritesUseCase(
            repository: repository
        )
        
        let fetchTop10MoviesUseCase =
            FetchTop10MoviesUseCase(
                repository: repository
            )

        let fetchNowPlayingUseCase = FetchNowPlayingUseCase(
            repository: repository
        )

        let fetchUpcomingUseCase = FetchUpcomingUseCase(
            repository: repository
        )
        
        let fetchMovieVideosUseCase = FetchMovieVideosUseCase(repository: repository)

        let fetchBornTodayActorsUseCase = FetchBornTodayActorsUseCase(repository: repository)
        
        let fetchMostPopularActorsUseCase = FetchMostPopularActorsUseCase( repository: repository)
        
        let fetchNewsUseCase = FetchNewsUseCase(repository: repository)
        
        
        // MARK: - Recently Viewed Use Cases

        let fetchRecentlyViewedMoviesUseCase =
            FetchRecentlyViewedMoviesUseCase(
                repository:
                    recentlyViewedRepository
            )

        let fetchRecentlyViewedActorsUseCase =
            FetchRecentlyViewedActorsUseCase(
                repository:
                    recentlyViewedRepository
            )

        let addRecentlyViewedMovieUseCase =
            AddRecentlyViewedMovieUseCase(
                repository:
                    recentlyViewedRepository
            )

        let addRecentlyViewedActorUseCase =
            AddRecentlyViewedActorUseCase(
                repository:
                    recentlyViewedRepository
            )
        
        // MARK: - ViewModel

        let viewModel = HomeViewModel(
            fetchTrendingUseCase:
                fetchTrendingUseCase,

            fetchPopularUseCase:
                fetchPopularUseCase,

            fetchTop10MoviesUseCase:
                fetchTop10MoviesUseCase,
            
            fetchFanFavouritesUseCase:
                fetchFanFavouritesUseCase,

            fetchNowPlayingUseCase:
                fetchNowPlayingUseCase,

            fetchUpcomingUseCase:
                fetchUpcomingUseCase,

            fetchMovieVideosUseCase:
                fetchMovieVideosUseCase,

            fetchBornTodayActorsUseCase:
                fetchBornTodayActorsUseCase,

            fetchMostPopularActorsUseCase:
                fetchMostPopularActorsUseCase,

            fetchNewsUseCase:
                fetchNewsUseCase,
            
            fetchRecentlyViewedMoviesUseCase:
                fetchRecentlyViewedMoviesUseCase,

            fetchRecentlyViewedActorsUseCase:
                fetchRecentlyViewedActorsUseCase,

            addRecentlyViewedMovieUseCase:
                addRecentlyViewedMovieUseCase,

            addRecentlyViewedActorUseCase:
                addRecentlyViewedActorUseCase
        )
        // MARK: - SwiftUI View

        let homeView = HomeView(
            viewModel: viewModel
        )

        // MARK: - Hosting Controller

        let hostingController = UIHostingController(
            rootView: homeView
        )

        return hostingController
    }

    public func makeHomeCoordinator(
        navigationController: UINavigationController
    ) -> HomeCoordinatorProtocol {
        HomeCoordinator(
            navigationController: navigationController,
            factory: self
        )
    }
}
