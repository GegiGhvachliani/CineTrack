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

import SharedNetworking
import TMDBData

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

        // MARK: - Repository

        let repository = HomeRepository(
            apiClient: apiClient,
            configuration: configuration
        )

        // MARK: - Use Cases

        let fetchTrendingUseCase = FetchTrendingUseCase(
            repository: repository
        )

        let fetchPopularUseCase = FetchPopularUseCase(
            repository: repository
        )

        let fetchTopRatedUseCase = FetchTopRatedUseCase(
            repository: repository
        )

        let fetchNowPlayingUseCase = FetchNowPlayingUseCase(
            repository: repository
        )

        let fetchUpcomingUseCase = FetchUpcomingUseCase(
            repository: repository
        )

        // MARK: - ViewModel

        let viewModel = HomeViewModel(
            fetchTrendingUseCase: fetchTrendingUseCase,
            fetchPopularUseCase: fetchPopularUseCase,
            fetchTopRatedUseCase: fetchTopRatedUseCase,
            fetchNowPlayingUseCase: fetchNowPlayingUseCase,
            fetchUpcomingUseCase: fetchUpcomingUseCase
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
