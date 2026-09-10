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
import LibraryData
import LibraryDomain
import SharedAuth
import SharedNetworking
import SharedStorage
import TMDBData

@MainActor
public struct SearchFactory: SearchFactoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let configuration: TMDBConfiguration
    private let firestore: RemoteDocumentStore
    private let userSession: UserSession

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        firestore: RemoteDocumentStore,
        userSession: UserSession
    ) {
        self.apiClient = apiClient
        self.configuration = configuration
        self.firestore = firestore
        self.userSession = userSession
    }

    public func makeSearchViewController(coordinator: SearchCoordinatorProtocol) -> UIViewController {

        // MARK: - Repository

        let repository = SearchRepository(
            apiClient: apiClient,
            configuration: configuration
        )
        let watchlistRepository = WatchlistRepository(
            firestore: firestore,
            userSession: userSession
        )
        let favouriteRepository = FavouriteRepository(
            firestore: firestore,
            userSession: userSession
        )

        // MARK: - Use Cases

        let searchMoviesUseCase = SearchMoviesUseCase(repository: repository)
        let searchActorsUseCase = SearchActorsUseCase(repository: repository)
        let discoverMoviesUseCase = DiscoverMoviesUseCase(repository: repository)

        // MARK: - ViewModel

        let viewModel = SearchViewModel(
            searchMoviesUseCase: searchMoviesUseCase,
            searchActorsUseCase: searchActorsUseCase,
            discoverMoviesUseCase: discoverMoviesUseCase,
            fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCase(repository: watchlistRepository),
            addWatchlistedMovieUseCase: AddWatchlistedMovieUseCase(repository: watchlistRepository),
            removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCase(repository: watchlistRepository),
            fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCase(repository: favouriteRepository),
            addFavouritedActorUseCase: AddFavouritedActorUseCase(repository: favouriteRepository),
            removeFavouritedActorUseCase: RemoveFavouritedActorUseCase(repository: favouriteRepository)
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
