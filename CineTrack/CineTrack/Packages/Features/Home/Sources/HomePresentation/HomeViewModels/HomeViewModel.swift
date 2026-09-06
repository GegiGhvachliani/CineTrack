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

    // MARK: - Actions

    public var onSearch: (() -> Void)?
    public var onVideos: ((FeaturedItem) -> Void)?
    public var onSeeAll: ((HomeSection) -> Void)?

    public var onMovieDetails: ((Movie) -> Void)?
    public var onActorDetails: ((Int) -> Void)?
    public var onNewsDetails: ((News) -> Void)?

    // MARK: - Movies

    public internal(set) var trendingMovies: [Movie] = []
    public internal(set) var popularMovies: [Movie] = []
    public internal(set) var fanFavouriteMovies: [Movie] = []
    public internal(set) var nowPlayingMovies: [Movie] = []
    public internal(set) var upcomingMovies: [Movie] = []
    public internal(set) var top10Movies: [Movie] = []

    public internal(set) var selectedFavouriteActor: Actor?
    public internal(set) var selectedFavouriteActorMovies: [Movie] = []


    // MARK: - Actors

    public internal(set) var bornTodayActors: [Actor] = []
    public internal(set) var mostPopularActors: [Actor] = []


    // MARK: - Featured Content

    public internal(set) var featuredItems: [FeaturedItem] = []
    public internal(set) var movieVideos: [Int: [MovieVideo]] = [:]


    // MARK: - News

    public internal(set) var news: [News] = []


    // MARK: - Recently Viewed

    public internal(set) var recentlyViewedMovies: [RecentlyViewedMovie] = []
    public internal(set) var recentlyViewedActors: [RecentlyViewedActor] = []

    public var recentlyViewedItems: [RecentlyViewedItem] {
        let movies = recentlyViewedMovies.map {
            RecentlyViewedItem.movie($0)
        }

        let actors = recentlyViewedActors.map {
            RecentlyViewedItem.actor($0)
        }

        return (movies + actors).sorted {
            $0.viewedAt > $1.viewedAt
        }
    }


    // MARK: - Watchlist

    public internal(set) var watchlistedMovies: [Movie] = []


    // MARK: - Favourites

    public internal(set) var favouritedActors: [Actor] = []
    
    // MARK: - Pending
    
    internal var pendingWatchlistIDs: Set<Int> = []
    internal var pendingFavouriteIDs: Set<Int> = []

    // MARK: - Loading State
    
    public internal(set) var isHomeLoading = false
    internal var hasLoadedInitialHome = false

    public internal(set) var isTrendingLoading = false
    public internal(set) var isPopularLoading = false
    public internal(set) var isFanFavouriteLoading = false
    public internal(set) var isNowPlayingLoading = false
    public internal(set) var isUpcomingLoading = false

    public internal(set) var isTop10Loading = false

    public internal(set) var isBornTodayActorsLoading = false
    public internal(set) var isMostPopularCelebritiesLoading = false

    public internal(set) var isNewsLoading = false

    public internal(set) var isRecentlyViewedLoading = false


    // MARK: - Pagination

    internal var trendingPage = 1
    internal var popularPage = 1
    internal var fanFavouritePage = 1
    internal var nowPlayingPage = 1
    internal var upcomingPage = 1

    internal var bornTodayActorsPage = 1
    internal var mostPopularCelebritiesPage = 1

    internal var newsPage = 1


    // MARK: - Pagination State

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


    // MARK: - Dependencies (UseCases)

    // MARK: Movies

    internal let fetchTrendingUseCase: FetchTrendingUseCaseProtocol
    internal let fetchPopularUseCase: FetchPopularUseCaseProtocol
    internal let fetchTop10MoviesUseCase: FetchTop10MoviesUseCaseProtocol
    internal let fetchFanFavouritesUseCase: FetchFanFavouritesUseCaseProtocol
    internal let fetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol
    internal let fetchUpcomingUseCase: FetchUpcomingUseCaseProtocol
    internal let fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol

    // MARK: Actors

    internal let fetchBornTodayActorsUseCase: FetchBornTodayActorsUseCaseProtocol
    internal let fetchMostPopularActorsUseCase: FetchMostPopularActorsUseCaseProtocol
    internal let fetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol

    // MARK: News

    internal let fetchNewsUseCase: FetchNewsUseCaseProtocol

    // MARK: Recently Viewed

    internal let fetchRecentlyViewedMoviesUseCase: FetchRecentlyViewedMoviesUseCaseProtocol
    internal let fetchRecentlyViewedActorsUseCase: FetchRecentlyViewedActorsUseCaseProtocol
    internal let addRecentlyViewedMovieUseCase: AddRecentlyViewedMovieUseCaseProtocol
    internal let addRecentlyViewedActorUseCase: AddRecentlyViewedActorUseCaseProtocol
    internal let clearRecentlyViewedUseCase: ClearRecentlyViewedUseCaseProtocol

    // MARK: Watchlist

    internal let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol
    internal let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol
    internal let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol

    // MARK: Favourites

    internal let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol
    internal let addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol
    internal let removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol

    // MARK: - Initialization

    public init(
        fetchTrendingUseCase: FetchTrendingUseCaseProtocol,
        fetchPopularUseCase: FetchPopularUseCaseProtocol,
        fetchTop10MoviesUseCase: FetchTop10MoviesUseCaseProtocol,
        fetchFanFavouritesUseCase: FetchFanFavouritesUseCaseProtocol,
        fetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol,
        fetchUpcomingUseCase: FetchUpcomingUseCaseProtocol,
        fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol,
        fetchBornTodayActorsUseCase: FetchBornTodayActorsUseCaseProtocol,
        fetchMostPopularActorsUseCase: FetchMostPopularActorsUseCaseProtocol,
        fetchNewsUseCase: FetchNewsUseCaseProtocol,
        fetchRecentlyViewedMoviesUseCase: FetchRecentlyViewedMoviesUseCaseProtocol,
        fetchRecentlyViewedActorsUseCase: FetchRecentlyViewedActorsUseCaseProtocol,
        addRecentlyViewedMovieUseCase: AddRecentlyViewedMovieUseCaseProtocol,
        addRecentlyViewedActorUseCase: AddRecentlyViewedActorUseCaseProtocol,
        clearRecentlyViewedUseCase: ClearRecentlyViewedUseCaseProtocol,
        fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol,
        addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol,
        removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol,
        fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol,
        addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol,
        removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol,
        fetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol,
    ) {
        self.fetchTrendingUseCase = fetchTrendingUseCase
        self.fetchPopularUseCase = fetchPopularUseCase
        self.fetchTop10MoviesUseCase = fetchTop10MoviesUseCase
        self.fetchFanFavouritesUseCase = fetchFanFavouritesUseCase
        self.fetchNowPlayingUseCase = fetchNowPlayingUseCase
        self.fetchUpcomingUseCase = fetchUpcomingUseCase
        self.fetchMovieVideosUseCase = fetchMovieVideosUseCase
        self.fetchBornTodayActorsUseCase = fetchBornTodayActorsUseCase
        self.fetchMostPopularActorsUseCase = fetchMostPopularActorsUseCase
        self.fetchNewsUseCase = fetchNewsUseCase
        self.fetchRecentlyViewedMoviesUseCase = fetchRecentlyViewedMoviesUseCase
        self.fetchRecentlyViewedActorsUseCase = fetchRecentlyViewedActorsUseCase
        self.addRecentlyViewedMovieUseCase = addRecentlyViewedMovieUseCase
        self.addRecentlyViewedActorUseCase = addRecentlyViewedActorUseCase
        self.clearRecentlyViewedUseCase = clearRecentlyViewedUseCase
        self.fetchWatchlistedMoviesUseCase = fetchWatchlistedMoviesUseCase
        self.addWatchlistedMovieUseCase = addWatchlistedMovieUseCase
        self.removeWatchlistedMovieUseCase = removeWatchlistedMovieUseCase
        self.fetchFavouritedActorsUseCase = fetchFavouritedActorsUseCase
        self.addFavouritedActorUseCase = addFavouritedActorUseCase
        self.removeFavouritedActorUseCase = removeFavouritedActorUseCase
        self.fetchActorMoviesUseCase = fetchActorMoviesUseCase
    }
}
