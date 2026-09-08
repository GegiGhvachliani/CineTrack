//
//  SearchFactory.swift
//  Search
//

import SwiftUI
import UIKit

import SearchData
import SearchDomain
import SearchPresentation
import SearchPresentationAPI
import SharedNetworking
import TMDBData

@MainActor
public struct SearchFactory: SearchFactoryProtocol {

    public init() {}

    public func makeSearchViewController(coordinator: SearchCoordinatorProtocol) -> UIViewController {

        // MARK: - API Client

        let apiClient = URLSessionAPIClient()

        // MARK: - TMDB Configuration

        let configuration = TMDBConfiguration(
            baseURL: URL(string: "https://api.themoviedb.org")!,
            accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NWEyZmRkNjQyY2FmOTMzYTVjMzk5N2VkY2VjYTRjNSIsIm5iZiI6MTc2Mzk4OTQxNS42MDA5OTk4LCJzdWIiOiI2OTI0NTdhN2EwYzRiMWIxMzIxODc1ZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ZfESC0ZJHYqzbSE2xCYRjfOSwiacjs7sYl-_qvgDbc4"
        )

        // MARK: - Repository

        let repository = SearchRepository(
            apiClient: apiClient,
            configuration: configuration
        )

        // MARK: - Use Cases

        let searchMoviesUseCase = SearchMoviesUseCase(repository: repository)
        let searchActorsUseCase = SearchActorsUseCase(repository: repository)
        let discoverMoviesUseCase = DiscoverMoviesUseCase(repository: repository)

        // MARK: - ViewModel

        let viewModel = SearchViewModel(
            searchMoviesUseCase: searchMoviesUseCase,
            searchActorsUseCase: searchActorsUseCase,
            discoverMoviesUseCase: discoverMoviesUseCase
        )

        viewModel.onMovieDetails = { [weak coordinator] movie in
            coordinator?.showMovieDetails(movie: movie)
        }

        viewModel.onActorDetails = { [weak coordinator] actorID in
            coordinator?.showActorDetails(actorID: actorID)
        }

        // MARK: - Hosting Controller

        return UIHostingController(rootView: SearchView(viewModel: viewModel))
    }

    public func makeSearchCoordinator(
        navigationController: UINavigationController,
        router: SearchRoutingProtocol
    ) -> SearchCoordinatorProtocol {
        SearchCoordinator(
            navigationController: navigationController,
            factory: self,
            router: router
        )
    }
}
