//
//  HomeViewModel.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import Observation

import HomeDomain
import SharedCore

@Observable
@MainActor
public final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Movies

    public internal(set) var trendingMovies: [Movie] = []
    public internal(set) var popularMovies: [Movie] = []
    public internal(set) var fanFavouriteMovies: [Movie] = []
    public internal(set) var nowPlayingMovies: [Movie] = []
    public internal(set) var upcomingMovies: [Movie] = []

    // MARK: - Top 10

    public internal(set) var top10Movies: [Movie] = []

    // MARK: - Actors

    public internal(set) var bornTodayActors: [Actor] = []
    public internal(set) var mostPopularActors: [Actor] = []

    // MARK: - News

    public internal(set) var news: [News] = []

    // MARK: - Videos

    public internal(set) var movieVideos: [Int: [MovieVideo]] = [:]
    public internal(set) var featuredItems: [FeaturedItem] = []

    // MARK: - Watchlist

    public internal(set) var watchlistedMovieIDs: Set<Int> = []

    // MARK: - Favourites

    public internal(set) var favouritedActorIDs: Set<Int> = []

    // MARK: - Loading State

    public internal(set) var isTrendingLoading = false
    public internal(set) var isPopularLoading = false
    public internal(set) var isFanFavouriteLoading = false
    public internal(set) var isNowPlayingLoading = false
    public internal(set) var isUpcomingLoading = false

    public internal(set) var isTop10Loading = false

    public internal(set) var isBornTodayActorsLoading = false
    public internal(set) var isMostPopularCelebritiesLoading = false

    public internal(set) var isNewsLoading = false

    // MARK: - Pagination

    internal var trendingPage = 1
    internal var popularPage = 1
    internal var fanFavouritePage = 1
    internal var nowPlayingPage = 1
    internal var upcomingPage = 1

    internal var bornTodayActorsPage = 1
    internal var mostPopularCelebritiesPage = 1

    internal var newsPage = 1

    public internal(set) var hasMoreTrending = true
    public internal(set) var hasMorePopular = true
    public internal(set) var hasMoreFanFavourite = true
    public internal(set) var hasMoreNowPlaying = true
    public internal(set) var hasMoreUpcoming = true

    public internal(set) var hasMoreBornTodayActors = true
    public internal(set) var hasMoreMostPopularCelebrities = true

    public internal(set) var hasMoreNews = true

    // MARK: - Error

    public internal(set) var error: Error?

    // MARK: - Dependencies

    internal let fetchTrendingUseCase:
        FetchTrendingUseCaseProtocol

    internal let fetchPopularUseCase:
        FetchPopularUseCaseProtocol
    
    internal let fetchTop10MoviesUseCase:
        FetchTop10MoviesUseCaseProtocol

    internal let fetchFanFavouritesUseCase:
        FetchFanFavouritesUseCaseProtocol

    internal let fetchNowPlayingUseCase:
        FetchNowPlayingUseCaseProtocol

    internal let fetchUpcomingUseCase:
        FetchUpcomingUseCaseProtocol

    internal let fetchMovieVideosUseCase:
        FetchMovieVideosUseCaseProtocol

    internal let fetchBornTodayActorsUseCase:
        FetchBornTodayActorsUseCaseProtocol

    internal let fetchMostPopularActorsUseCase:
        FetchMostPopularActorsUseCaseProtocol

    internal let fetchNewsUseCase:
        FetchNewsUseCaseProtocol

    // MARK: - Initialization

    public init(
        fetchTrendingUseCase:
            FetchTrendingUseCaseProtocol,
        fetchPopularUseCase:
            FetchPopularUseCaseProtocol,
        fetchTop10MoviesUseCase:
            FetchTop10MoviesUseCaseProtocol,
        fetchFanFavouritesUseCase:
            FetchFanFavouritesUseCaseProtocol,
        fetchNowPlayingUseCase:
            FetchNowPlayingUseCaseProtocol,
        fetchUpcomingUseCase:
            FetchUpcomingUseCaseProtocol,
        fetchMovieVideosUseCase:
            FetchMovieVideosUseCaseProtocol,
        fetchBornTodayActorsUseCase:
            FetchBornTodayActorsUseCaseProtocol,
        fetchMostPopularActorsUseCase:
            FetchMostPopularActorsUseCaseProtocol,
        fetchNewsUseCase:
            FetchNewsUseCaseProtocol
    ) {
        self.fetchTrendingUseCase =
            fetchTrendingUseCase

        self.fetchPopularUseCase =
            fetchPopularUseCase

        self.fetchTop10MoviesUseCase =
            fetchTop10MoviesUseCase
        
        self.fetchFanFavouritesUseCase =
            fetchFanFavouritesUseCase

        self.fetchNowPlayingUseCase =
            fetchNowPlayingUseCase

        self.fetchUpcomingUseCase =
            fetchUpcomingUseCase

        self.fetchMovieVideosUseCase =
            fetchMovieVideosUseCase

        self.fetchBornTodayActorsUseCase =
            fetchBornTodayActorsUseCase

        self.fetchMostPopularActorsUseCase =
            fetchMostPopularActorsUseCase

        self.fetchNewsUseCase =
            fetchNewsUseCase
    }
}
