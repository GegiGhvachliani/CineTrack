//
//  HomeViewModel.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import Combine
import Observation // დამატებულია Observation ფრეიმვორკი
import HomeDomain
import SharedCore

@MainActor
public protocol HomeViewModelProtocol {
    
    // MARK: - Born Today Actors

    var bornTodayActors: [Actor] { get }

    // MARK: - Movies

    var trendingMovies: [Movie] { get }
    var popularMovies: [Movie] { get }
    var topRatedMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }

    // MARK: - Videos

    var movieVideos: [Int: [MovieVideo]] { get }
    var featuredItems: [FeaturedItem] { get }

    // MARK: - Watchlist
    var watchlistedMovieIDs: Set<Int> { get }

    // MARK: - Loading State

    var isTrendingLoading: Bool { get }
    var isPopularLoading: Bool { get }
    var isTopRatedLoading: Bool { get }
    var isNowPlayingLoading: Bool { get }
    var isUpcomingLoading: Bool { get }
    var isBornTodayActorsLoading: Bool { get }


    // MARK: - Pagination State

    var hasMoreTrending: Bool { get }
    var hasMorePopular: Bool { get }
    var hasMoreTopRated: Bool { get }
    var hasMoreNowPlaying: Bool { get }
    var hasMoreUpcoming: Bool { get }
    var hasMoreBornTodayActors: Bool { get }


    // MARK: - Error

    var error: Error? { get }

    // MARK: - Public Methods

    func loadHome() async

    func loadNextTrendingPage() async
    func loadNextPopularPage() async
    func loadNextTopRatedPage() async
    func loadNextNowPlayingPage() async
    func loadNextUpcomingPage() async
    func loadNextBornTodayActorsPage() async


    func loadVideos(for movie: Movie) async
    func toggleWatchlist(for movie: Movie)

    func clearError()
}

@Observable
@MainActor
public final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties

    public private(set) var trendingMovies: [Movie] = []
    public private(set) var popularMovies: [Movie] = []
    public private(set) var topRatedMovies: [Movie] = []
    public private(set) var nowPlayingMovies: [Movie] = []
    public private(set) var upcomingMovies: [Movie] = []
    public private(set) var bornTodayActors: [Actor] = []

    
    public private(set) var favouritedActorIDs: Set<Int> = []
    
    public private(set) var movieVideos: [Int: [MovieVideo]] = [:]
    public private(set) var featuredItems: [FeaturedItem] = []
    
    // MARK: - Watchlist
    
    public private(set) var watchlistedMovieIDs: Set<Int> = []

    // MARK: - Loading State

    public private(set) var isTrendingLoading = false
    public private(set) var isPopularLoading = false
    public private(set) var isTopRatedLoading = false
    public private(set) var isNowPlayingLoading = false
    public private(set) var isUpcomingLoading = false
    public private(set) var isBornTodayActorsLoading = false


    // MARK: - Pagination State

    private var trendingPage = 1
    private var popularPage = 1
    private var topRatedPage = 1
    private var nowPlayingPage = 1
    private var upcomingPage = 1
    private var bornTodayActorsPage = 1
    public private(set) var hasMoreBornTodayActors = true


    public private(set) var hasMoreTrending = true
    public private(set) var hasMorePopular = true
    public private(set) var hasMoreTopRated = true
    public private(set) var hasMoreNowPlaying = true
    public private(set) var hasMoreUpcoming = true

    // MARK: - Error

    public private(set) var error: Error?

    // MARK: - Dependencies

    private let fetchTrendingUseCase: FetchTrendingUseCaseProtocol
    private let fetchPopularUseCase: FetchPopularUseCaseProtocol
    private let fetchTopRatedUseCase: FetchTopRatedUseCaseProtocol
    private let fetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol
    private let fetchUpcomingUseCase: FetchUpcomingUseCaseProtocol
    private let fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol
    private let fetchBornTodayActorsUseCase:
        FetchBornTodayActorsUseCaseProtocol

    // MARK: - Initialization

    public init(
        fetchTrendingUseCase: FetchTrendingUseCaseProtocol,
        fetchPopularUseCase: FetchPopularUseCaseProtocol,
        fetchTopRatedUseCase: FetchTopRatedUseCaseProtocol,
        fetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol,
        fetchUpcomingUseCase: FetchUpcomingUseCaseProtocol,
        fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol,
        fetchBornTodayActorsUseCase: FetchBornTodayActorsUseCaseProtocol
    ) {
        self.fetchTrendingUseCase = fetchTrendingUseCase
        self.fetchPopularUseCase = fetchPopularUseCase
        self.fetchTopRatedUseCase = fetchTopRatedUseCase
        self.fetchNowPlayingUseCase = fetchNowPlayingUseCase
        self.fetchUpcomingUseCase = fetchUpcomingUseCase
        self.fetchMovieVideosUseCase = fetchMovieVideosUseCase
        self.fetchBornTodayActorsUseCase = fetchBornTodayActorsUseCase
    }

    // MARK: - Initial Loading

    public func loadHome() async {

        error = nil

        async let trending = loadNextTrendingPage()

        async let popular = loadNextPopularPage()

        async let topRated = loadNextTopRatedPage()

        async let nowPlaying = loadNextNowPlayingPage()

        async let upcoming = loadNextUpcomingPage()

        async let bornToday = loadNextBornTodayActorsPage()

        await (
            trending,
            popular,
            topRated,
            nowPlaying,
            upcoming,
            bornToday
        )

        await loadFeaturedItems()
    }

    // MARK: - Trending

    public func loadNextTrendingPage() async {
        guard !isTrendingLoading, hasMoreTrending else { return }

        isTrendingLoading = true
        error = nil

        defer { isTrendingLoading = false }

        do {
            let page = try await fetchTrendingUseCase.execute(page: trendingPage)
            trendingMovies.append(contentsOf: page.movies)
            trendingPage = page.page + 1
            hasMoreTrending = page.hasNextPage
        } catch {
            self.error = error
        }
    }

    // MARK: - Popular

    public func loadNextPopularPage() async {
        guard !isPopularLoading, hasMorePopular else { return }

        isPopularLoading = true
        error = nil

        defer { isPopularLoading = false }

        do {
            let page = try await fetchPopularUseCase.execute(page: popularPage)
            popularMovies.append(contentsOf: page.movies)
            popularPage = page.page + 1
            hasMorePopular = page.hasNextPage
        } catch {
            self.error = error
        }
    }

    // MARK: - Top Rated

    public func loadNextTopRatedPage() async {
        guard !isTopRatedLoading, hasMoreTopRated else { return }

        isTopRatedLoading = true
        error = nil

        defer { isTopRatedLoading = false }

        do {
            let page = try await fetchTopRatedUseCase.execute(page: topRatedPage)
            topRatedMovies.append(contentsOf: page.movies)
            topRatedPage = page.page + 1
            hasMoreTopRated = page.hasNextPage
        } catch {
            self.error = error
        }
    }

    // MARK: - Now Playing

    public func loadNextNowPlayingPage() async {
        guard !isNowPlayingLoading, hasMoreNowPlaying else { return }

        isNowPlayingLoading = true
        error = nil

        defer { isNowPlayingLoading = false }

        do {
            let page = try await fetchNowPlayingUseCase.execute(page: nowPlayingPage)
            nowPlayingMovies.append(contentsOf: page.movies)
            nowPlayingPage = page.page + 1
            hasMoreNowPlaying = page.hasNextPage
        } catch {
            self.error = error
        }
    }

    // MARK: - Upcoming

    public func loadNextUpcomingPage() async {
        guard !isUpcomingLoading, hasMoreUpcoming else { return }

        isUpcomingLoading = true
        error = nil

        defer { isUpcomingLoading = false }

        do {
            let page = try await fetchUpcomingUseCase.execute(page: upcomingPage)
            upcomingMovies.append(contentsOf: page.movies)
            upcomingPage = page.page + 1
            hasMoreUpcoming = page.hasNextPage
        } catch {
            self.error = error
        }
    }

    // MARK: - Videos

    public func loadVideos(for movie: Movie) async {
        error = nil

        do {
            let videos = try await fetchMovieVideosUseCase.execute(movieID: movie.id)
            movieVideos[movie.id] = videos
        } catch {
            self.error = error
        }
    }

    // MARK: - Featured

    public func loadFeaturedItems() async {
        let movies = Array(nowPlayingMovies.prefix(5))

        guard !movies.isEmpty else {
            featuredItems = []
            return
        }

        let items = await withTaskGroup(of: (Int, FeaturedItem?).self) { group in
            for (index, movie) in movies.enumerated() {
                group.addTask {
                    do {
                        let videos = try await self.fetchMovieVideosUseCase.execute(movieID: movie.id)
                        guard let video = await self.selectFeaturedVideo(from: videos) else {
                            return (index, nil)
                        }
                        let item = FeaturedItem(movie: movie, video: video)
                        return (index, item)
                    } catch {
                        return (index, nil)
                    }
                }
            }

            var results: [(Int, FeaturedItem)] = []
            for await (index, item) in group {
                if let item {
                    results.append((index, item))
                }
            }

            return results
                .sorted { $0.0 < $1.0 }
                .map(\.1)
        }

        featuredItems = items
    }
    
    // MARK: - Born Today Actors

    public func loadNextBornTodayActorsPage() async {

        guard
            !isBornTodayActorsLoading,
            hasMoreBornTodayActors
        else {
            return
        }

        isBornTodayActorsLoading = true

        defer {
            isBornTodayActorsLoading = false
        }

        do {
            let page = try await fetchBornTodayActorsUseCase.execute(
                page: bornTodayActorsPage
            )

            bornTodayActors.append(
                contentsOf: page.actors
            )

            bornTodayActorsPage += 1

            hasMoreBornTodayActors =
                page.hasNextPage

        } catch {
            self.error = error
        }
    }
    
    
    

    // MARK: - Video Selection

    private func selectFeaturedVideo(from videos: [MovieVideo]) -> MovieVideo? {
        let priority: [VideoType] = [
            .behindTheScenes,
            .trailer,
            .featurette,
            .bloopers
        ]

        for type in priority {
            if let officialVideo = videos.first(where: {
                $0.type == type && $0.site == .youtube && $0.official
            }) {
                return officialVideo
            }

            if let video = videos.first(where: {
                $0.type == type && $0.site == .youtube
            }) {
                return video
            }
        }
        return nil
    }

    // MARK: - Watchlist Management
    
    public func toggleWatchlist(for movie: Movie) {
        if watchlistedMovieIDs.contains(movie.id) {
            watchlistedMovieIDs.remove(movie.id)
        } else {
            watchlistedMovieIDs.insert(movie.id)
        }
    }
    
    // MARK: - Favourite Management

    public func toggleFavourite(for actor: Actor) {
        if favouritedActorIDs.contains(actor.id) {

            favouritedActorIDs.remove(actor.id)

        } else {

            favouritedActorIDs.insert(actor.id)
        }
    }
    
    // MARK: - Error Handling

    public func clearError() {
        error = nil
    }
}
