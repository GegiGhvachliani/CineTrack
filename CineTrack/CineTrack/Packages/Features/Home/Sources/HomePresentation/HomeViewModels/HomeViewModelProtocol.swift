//
//  HomeViewModelProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

//
//  HomeViewModelProtocol.swift
//  Home
//

import Foundation

import HomeDomain
import SharedCore

@MainActor
public protocol HomeViewModelProtocol {

    // MARK: - Actions

    var onSearch: (() -> Void)? { get }
    var onVideos: ((FeaturedItem) -> Void)? { get }
    var onSeeAll: ((HomeSection) -> Void)? { get }

    var onMovieDetails: ((Movie) -> Void)? { get }
    var onActorDetails: ((Actor) -> Void)? { get }
    var onNewsDetails: ((News) -> Void)? { get }

    func didTapSearch()
    func didTapMovie(_ movie: Movie)
    func didTapVideos(_ item: FeaturedItem)
    func didTapActor(_ actor: Actor)
    func didTapSeeAll(_ section: HomeSection)
    func didTapNews(_ news: News)

    // MARK: - Movies

    var trendingMovies: [Movie] { get }
    var popularMovies: [Movie] { get }
    var fanFavouriteMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }

    func loadNextTrendingPage() async
    func loadNextPopularPage() async
    func loadNextFanFavouritePage() async
    func loadNextNowPlayingPage() async
    func loadNextUpcomingPage() async

    // MARK: - Recently Viewed

    var recentlyViewedMovies: [RecentlyViewedMovie] { get }
    var recentlyViewedActors: [RecentlyViewedActor] { get }
    var recentlyViewedItems: [RecentlyViewedItem] { get }

    var isRecentlyViewedLoading: Bool { get }

    func loadRecentlyViewed() async
    func addRecentlyViewed(movie: Movie) async
    func addRecentlyViewed(actor: Actor) async
    func clearRecentlyViewed() async

    // MARK: - Top 10

    var top10Movies: [Movie] { get }
    var isTop10Loading: Bool { get }

    func loadTop10Movies() async

    // MARK: - Actors

    var bornTodayActors: [Actor] { get }
    var mostPopularActors: [Actor] { get }

    var isBornTodayActorsLoading: Bool { get }
    var isMostPopularCelebritiesLoading: Bool { get }

    func loadNextBornTodayActorsPage() async
    func loadNextMostPopularCelebritiesPage() async

    // MARK: - News

    var news: [News] { get }
    var isNewsLoading: Bool { get }

    func loadNextNewsPage() async

    // MARK: - Featured

    var featuredItems: [FeaturedItem] { get }

    // MARK: - Videos

    var movieVideos: [Int: [MovieVideo]] { get }

    func loadVideos(for movie: Movie) async

    // MARK: - Watchlist

    var watchlistedMovies: [Movie] { get }

    func loadWatchlist() async
    func toggleWatchlist(for movie: Movie) async

    // MARK: - Favourites

    var favouritedActors: [Actor] { get }

    func loadFavourites() async
    func toggleFavourite(for actor: Actor) async

    // MARK: - Loading

    var isHomeLoading: Bool { get }

    // MARK: - Pagination

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

    func clearError()

    // MARK: - Initial Loading

    func loadHome() async
}
