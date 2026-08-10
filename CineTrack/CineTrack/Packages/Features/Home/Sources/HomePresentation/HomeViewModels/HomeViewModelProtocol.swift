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

    // MARK: Movies

    var trendingMovies: [Movie] { get }
    var popularMovies: [Movie] { get }
    var topRatedMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }

    // MARK: Actors

    var bornTodayActors: [Actor] { get }
    var mostPopularActors: [Actor] { get }

    // MARK: News

    var news: [News] { get }

    // MARK: Videos

    var movieVideos: [Int: [MovieVideo]] { get }
    var featuredItems: [FeaturedItem] { get }

    // MARK: Watchlist

    var watchlistedMovieIDs: Set<Int> { get }

    // MARK: Favourites

    var favouritedActorIDs: Set<Int> { get }

    // MARK: Loading State

    var isTrendingLoading: Bool { get }
    var isPopularLoading: Bool { get }
    var isTopRatedLoading: Bool { get }
    var isNowPlayingLoading: Bool { get }
    var isUpcomingLoading: Bool { get }

    var isBornTodayActorsLoading: Bool { get }
    var isMostPopularCelebritiesLoading: Bool { get }

    var isNewsLoading: Bool { get }

    // MARK: Pagination State

    var hasMoreTrending: Bool { get }
    var hasMorePopular: Bool { get }
    var hasMoreTopRated: Bool { get }
    var hasMoreNowPlaying: Bool { get }
    var hasMoreUpcoming: Bool { get }

    var hasMoreBornTodayActors: Bool { get }
    var hasMoreMostPopularCelebrities: Bool { get }

    var hasMoreNews: Bool { get }

    // MARK: Error

    var error: Error? { get }

    // MARK: Public Methods

    func loadHome() async

    // Movies
    func loadNextTrendingPage() async
    func loadNextPopularPage() async
    func loadNextTopRatedPage() async
    func loadNextNowPlayingPage() async
    func loadNextUpcomingPage() async

    // Actors
    func loadNextBornTodayActorsPage() async
    func loadNextMostPopularCelebritiesPage() async

    // News
    func loadNextNewsPage() async

    // Videos
    func loadVideos(for movie: Movie) async

    // Watchlist
    func toggleWatchlist(for movie: Movie)

    // Favourites
    func toggleFavourite(for actor: Actor)

    // Error
    func clearError()
}
