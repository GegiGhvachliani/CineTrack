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
import HomeData
import HomeDomain

@MainActor
public struct MovieDetailsFactory: MovieDetailsFactoryProtocol {

    public init() {}

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
        // MARK: - API client

        let apiClient = URLSessionAPIClient()

        // MARK: - Configuration

        let tmdbConfiguration = TMDBConfiguration(
            baseURL: URL(string: "https://api.themoviedb.org")!,
            accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NWEyZmRkNjQyY2FmOTMzYTVjMzk5N2VkY2VjYTRjNSIsIm5iZiI6MTc2Mzk4OTQxNS42MDA5OTk4LCJzdWIiOiI2OTI0NTdhN2EwYzRiMWIxMzIxODc1ZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ZfESC0ZJHYqzbSE2xCYRjfOSwiacjs7sYl-_qvgDbc4"
        )
        let newsConfiguration = NewsConfiguration(
            baseURL: URL(string: "https://newsapi.org")!,
            apiKey: Bundle.main.object(
                forInfoDictionaryKey: "NEWS_API_KEY"
            ) as? String ?? ""
        )

        // MARK: - Repositories

        let repository = MovieDetailsRepository(
            apiClient: apiClient,
            configuration: tmdbConfiguration,
            newsConfiguration: newsConfiguration
        )
        let watchlistRepository = MovieDetailsData.WatchlistRepository(
            firestore: FirestoreClient(),
            userSession: FirebaseUserSession()
        )
        let recentlyViewedRepository = RecentlyViewedRepository(
            firestore: FirestoreClient(),
            userSession: FirebaseUserSession()
        )

        // MARK: - View model

        let viewModel = MovieDetailsViewModel(
            movie: movie,
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
        viewModel.onMovieViewed = { (movie: Movie) in
            Task {
                let recentlyViewedMovie = RecentlyViewedMovie(
                    id: movie.id,
                    title: movie.title,
                    posterPath: movie.posterPath,
                    releaseDate: movie.releaseDate,
                    voteAverage: movie.voteAverage,
                    viewedAt: .now
                )

                try? await recentlyViewedRepository.addRecentlyViewedMovie(
                    recentlyViewedMovie
                )
            }
        }

        let view = MovieDetailsView(viewModel: viewModel)

        return UIHostingController(rootView: view)
    }
}
