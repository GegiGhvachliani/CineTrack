//
//  MovieDetailsViewModel.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import LibraryDomain
import Observation

import MovieDetailsDomain
import SharedCore

@Observable
@MainActor
public final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {

    // MARK: - Movie

    public let movie: Movie
    public internal(set) var movieDetails: MovieDetails?
    public internal(set) var cast: [MovieCastMember] = []
    public internal(set) var videos: [MovieVideo] = []
    public internal(set) var images: [MovieImage] = []
    public internal(set) var similarMovies: [Movie] = []
    public internal(set) var selectedActor: MovieCastMember?
    public internal(set) var selectedActorMovies: [Movie] = []
    public internal(set) var news: [News] = []

    public var videosSectionFeaturedVideo: MovieVideo? {
        videos
            .filter { $0.type != .trailer }
            .sorted(by: videoSortOrder)
            .first
    }

    public var videosSectionAdditionalVideos: [MovieVideo] {
        guard let videosSectionFeaturedVideo else {
            return []
        }

        return videos.filter { $0.id != videosSectionFeaturedVideo.id }
    }

    // MARK: - Watchlist

    public internal(set) var watchlistedMovieIDs = Set<Int>()
    public internal(set) var pendingWatchlistIDs = Set<Int>()

    public var isWatchlisted: Bool {
        isWatchlisted(movie)
    }

    public var isWatchlistUpdating: Bool {
        pendingWatchlistIDs.contains(movie.id)
    }

    // MARK: - Loading state

    public internal(set) var isLoading = false
    public internal(set) var isCastLoading = false
    public internal(set) var isVideosLoading = false
    public internal(set) var isImagesLoading = false
    public internal(set) var isSimilarMoviesLoading = false
    public internal(set) var isRelatedActorLoading = false
    public internal(set) var isNewsLoading = false
    public internal(set) var error: Error?
    public internal(set) var sectionErrors: [MovieDetailsSection: Error] = [:]

    // MARK: - Actions

    public var onMovieDetails: ((Movie) -> Void)?
    public var onActorDetails: ((Int) -> Void)?
    public var onNewsDetails: ((News) -> Void)?
    public var onShowSeeAll: ((SeeAllContent) -> Void)?
    public var onShowVideos: ((VideoPlaylistContext) -> Void)?

    // MARK: - Dependencies

    let addRecentlyViewedMovieUseCase: AddRecentlyViewedMovieUseCaseProtocol
    let fetchMovieDetailsUseCase: FetchMovieDetailsUseCaseProtocol
    let fetchMovieCastUseCase: FetchMovieCastUseCaseProtocol
    let fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol
    let fetchMovieImagesUseCase: FetchMovieImagesUseCaseProtocol
    let fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCaseProtocol
    let fetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol
    let fetchMovieNewsUseCase: FetchMovieNewsUseCaseProtocol
    let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol
    let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol
    let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol

    var hasLoadedInitialContent = false

    // MARK: - Initialization

    public init(
        movie: Movie,
        addRecentlyViewedMovieUseCase: AddRecentlyViewedMovieUseCaseProtocol,
        fetchMovieDetailsUseCase: FetchMovieDetailsUseCaseProtocol,
        fetchMovieCastUseCase: FetchMovieCastUseCaseProtocol,
        fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol,
        fetchMovieImagesUseCase: FetchMovieImagesUseCaseProtocol,
        fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCaseProtocol,
        fetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol,
        fetchMovieNewsUseCase: FetchMovieNewsUseCaseProtocol,
        fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol,
        addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol,
        removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol
    ) {
        self.movie = movie
        self.addRecentlyViewedMovieUseCase = addRecentlyViewedMovieUseCase
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.fetchMovieCastUseCase = fetchMovieCastUseCase
        self.fetchMovieVideosUseCase = fetchMovieVideosUseCase
        self.fetchMovieImagesUseCase = fetchMovieImagesUseCase
        self.fetchSimilarMoviesUseCase = fetchSimilarMoviesUseCase
        self.fetchActorMoviesUseCase = fetchActorMoviesUseCase
        self.fetchMovieNewsUseCase = fetchMovieNewsUseCase
        self.fetchWatchlistedMoviesUseCase = fetchWatchlistedMoviesUseCase
        self.addWatchlistedMovieUseCase = addWatchlistedMovieUseCase
        self.removeWatchlistedMovieUseCase = removeWatchlistedMovieUseCase
    }

}
