//
//  HomeViewModelProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

import HomeDomain
import SharedCore

@MainActor
public protocol HomeViewModelProtocol {

    // MARK: - Movies

    var trendingMovies: [Movie] { get }
    var popularMovies: [Movie] { get }
    var fanFavouriteMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }

    // MARK: - Recently Viewed

    var recentlyViewedMovies: [RecentlyViewedMovie] { get }
    var recentlyViewedActors: [RecentlyViewedActor] { get }
    var recentlyViewedItems: [RecentlyViewedItem] { get }

    var isRecentlyViewedLoading: Bool { get }

    // MARK: - Top 10

    var top10Movies: [Movie] { get }

    // MARK: - Actors

    var bornTodayActors: [Actor] { get }
    var mostPopularActors: [Actor] { get }

    // MARK: - News

    var news: [News] { get }

    // MARK: - Videos

    var movieVideos: [Int: [MovieVideo]] { get }
    var featuredItems: [FeaturedItem] { get }

    // MARK: - Watchlist

    var watchlistedMovieIDs: Set<Int> { get }

    // MARK: - Favourites

    var favouritedActorIDs: Set<Int> { get }

    // MARK: - Loading State

    var isTrendingLoading: Bool { get }
    var isPopularLoading: Bool { get }
    var isFanFavouriteLoading: Bool { get }
    var isNowPlayingLoading: Bool { get }
    var isUpcomingLoading: Bool { get }

    var isTop10Loading: Bool { get }

    var isBornTodayActorsLoading: Bool { get }
    var isMostPopularCelebritiesLoading: Bool { get }

    var isNewsLoading: Bool { get }

    // MARK: - Pagination State

    var hasMoreTrending: Bool { get }
    var hasMorePopular: Bool { get }
    var hasMoreFanFavourite: Bool { get }
    var hasMoreNowPlaying: Bool { get }
    var hasMoreUpcoming: Bool { get }

    var hasMoreBornTodayActors: Bool { get }
    var hasMoreMostPopularCelebrities: Bool { get }

    var hasMoreNews: Bool { get }

    // MARK: - Error

    var error: Error? { get }

    // MARK: - Public Methods

    func loadHome() async

    // MARK: - Movies

    func loadNextTrendingPage() async
    func loadNextPopularPage() async
    func loadNextFanFavouritePage() async
    func loadNextNowPlayingPage() async
    func loadNextUpcomingPage() async

    // MARK: - Recently Viewed

    func loadRecentlyViewed() async

    func addRecentlyViewed(
        movie: Movie
    ) async

    func addRecentlyViewed(
        actor: Actor
    ) async

    // MARK: - Top 10

    func loadTop10Movies() async

    // MARK: - Actors

    func loadNextBornTodayActorsPage() async
    func loadNextMostPopularCelebritiesPage() async

    // MARK: - News

    func loadNextNewsPage() async

    // MARK: - Videos

    func loadVideos(
        for movie: Movie
    ) async

    // MARK: - Watchlist

    func toggleWatchlist(
        for movie: Movie
    )

    // MARK: - Favourites

    func toggleFavourite(
        for actor: Actor
    )

    // MARK: - Error

    func clearError()
}
