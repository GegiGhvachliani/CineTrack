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

    // MARK: - Navigation & User Actions (Coordinator / Flow)

    var onSearch: (() -> Void)? { get }
    var onVideos: ((FeaturedItem) -> Void)? { get }
    var onSeeAll: ((HomeSection) -> Void)? { get }
    var onMovieDetails: ((Movie) -> Void)? { get }
    var onActorDetails: ((Int) -> Void)? { get }
    var onNewsDetails: ((News) -> Void)? { get }

    func didTapSearch()
    func didTapMovie(_ movie: Movie)
    func didTapVideos(_ item: FeaturedItem)
    func didTapActor(_ actor: Actor)
    func didTapSeeAll(_ section: HomeSection)
    func didTapNews(_ news: News)

    // MARK: - Overall Home State & Lifecycle

    var isHomeLoading: Bool { get }
    var error: Error? { get }

    func loadHome() async
    func clearError()

    // MARK: - Featured & Videos

    var featuredItems: [FeaturedItem] { get }
    var movieVideos: [Int: [MovieVideo]] { get }

    func loadVideos(for movie: Movie) async

    // MARK: - Top 10

    var top10Movies: [Movie] { get }
    var isTop10Loading: Bool { get }

    func loadTop10Movies() async

    // MARK: - Movies & Pagination

    var trendingMovies: [Movie] { get }
    var popularMovies: [Movie] { get }
    var fanFavouriteMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }

    var hasMoreTrending: Bool { get }
    var hasMorePopular: Bool { get }
    var hasMoreFanFavourite: Bool { get }
    var hasMoreNowPlaying: Bool { get }
    var hasMoreUpcoming: Bool { get }

    func loadNextTrendingPage() async
    func loadNextPopularPage() async
    func loadNextFanFavouritePage() async
    func loadNextNowPlayingPage() async
    func loadNextUpcomingPage() async

    // MARK: - Actors & Celebrities

    var bornTodayActors: [Actor] { get }
    var mostPopularActors: [Actor] { get }

    var isBornTodayActorsLoading: Bool { get }
    var isMostPopularCelebritiesLoading: Bool { get }

    var hasMoreBornTodayActors: Bool { get }
    var hasMoreMostPopularCelebrities: Bool { get }

    func loadNextBornTodayActorsPage() async
    func loadNextMostPopularCelebritiesPage() async

    // MARK: - News

    var news: [News] { get }
    var isNewsLoading: Bool { get }
    var hasMoreNews: Bool { get }

    func loadNextNewsPage() async

    // MARK: - Recently Viewed

    var recentlyViewedMovies: [RecentlyViewedMovie] { get }
    var recentlyViewedActors: [RecentlyViewedActor] { get }
    var recentlyViewedItems: [RecentlyViewedItem] { get }
    var isRecentlyViewedLoading: Bool { get }

    func loadRecentlyViewed() async
    func addRecentlyViewed(movie: Movie) async
    func addRecentlyViewed(actor: Actor) async
    func clearRecentlyViewed() async

    // MARK: - User Personalization (Watchlist & Favourites)

    var watchlistedMovies: [Movie] { get }
    var favouritedActors: [Actor] { get }

    func loadWatchlist() async
    func toggleWatchlist(for movie: Movie) async
    func loadFavourites() async
    func toggleFavourite(for actor: Actor) async
}
