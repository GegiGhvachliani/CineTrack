//
//  MovieDetailsFactory.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SharedCore
import SharedAuth
import SharedNetworking
import SharedStorage
import TMDBData
import NewsData
import MovieDetailsData
import MovieDetailsDomain
import MovieDetailsPresentation
import MovieDetailsPresentationAPI
import LibraryData
import LibraryDomain

@MainActor
public struct MovieDetailsFactory: MovieDetailsFactoryProtocol {

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

    public func makeMovieDetailsCoordinator(
        movie: Movie,
        navigationController: UINavigationController,
        router: MovieDetailsRoutingProtocol
    ) -> MovieDetailsCoordinatorProtocol {
        MovieDetailsCoordinator(
            movie: movie,
            navigationController: navigationController,
            factory: self,
            router: router
        )
    }

    public func makeMovieDetailsViewController(
        movie: Movie,
        onMovieDetails: @escaping (Movie) -> Void,
        onActorDetails: @escaping (Int) -> Void,
        onNewsDetails: @escaping (News) -> Void,
        onShowSeeAll: @escaping (SeeAllContent) -> Void,
        onShowVideos: @escaping (VideoPlaylistContext) -> Void
    ) -> UIViewController {

        // MARK: - Repositories

        let repository = MovieDetailsRepository(
            apiClient: apiClient,
            configuration: tmdbConfiguration,
            newsConfiguration: newsConfiguration
        )
        let watchlistRepository = LibraryData.WatchlistRepository(
            firestore: firestore,
            userSession: userSession
        )
        let recentlyViewedRepository = RecentlyViewedRepository(
            firestore: firestore,
            userSession: userSession
        )

        // MARK: - View model

        let viewModel = MovieDetailsViewModel(
            movie: movie,
            addRecentlyViewedMovieUseCase: AddRecentlyViewedMovieUseCase(repository: recentlyViewedRepository),
            fetchMovieDetailsUseCase: FetchMovieDetailsUseCase(
                repository: repository
            ),
            fetchMovieCastUseCase: FetchMovieCastUseCase(
                repository: repository
            ),
            fetchMovieVideosUseCase: FetchMovieVideosUseCase(
                repository: repository
            ),
            fetchMovieImagesUseCase: FetchMovieImagesUseCase(
                repository: repository
            ),
            fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCase(
                repository: repository
            ),
            fetchActorMoviesUseCase: FetchActorMoviesUseCase(
                repository: repository
            ),
            fetchMovieNewsUseCase: FetchMovieNewsUseCase(
                repository: repository
            ),
            fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCase(
                repository: watchlistRepository
            ),
            addWatchlistedMovieUseCase: AddWatchlistedMovieUseCase(
                repository: watchlistRepository
            ),
            removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCase(
                repository: watchlistRepository
            )
        )
        viewModel.onMovieDetails = onMovieDetails
        viewModel.onActorDetails = onActorDetails
        viewModel.onNewsDetails = onNewsDetails
        viewModel.onShowSeeAll = onShowSeeAll
        viewModel.onShowVideos = onShowVideos

        let view = MovieDetailsView(viewModel: viewModel)

        return UIHostingController(rootView: view)
    }
}
