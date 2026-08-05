//
//  HomeViewModel.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import Combine
import HomeDomain
import SharedCore

@MainActor
public protocol HomeViewModelProtocol: ObservableObject {

    // MARK: - Movies

    var trendingMovies: [Movie] { get }
    var popularMovies: [Movie] { get }
    var topRatedMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }

    // MARK: - Videos

    var movieVideos: [Int: [MovieVideo]] { get }
    var featuredItems: [FeaturedItem] { get }

    // MARK: - Loading State

    var isTrendingLoading: Bool { get }
    var isPopularLoading: Bool { get }
    var isTopRatedLoading: Bool { get }
    var isNowPlayingLoading: Bool { get }
    var isUpcomingLoading: Bool { get }

    // MARK: - Pagination State

    var hasMoreTrending: Bool { get }
    var hasMorePopular: Bool { get }
    var hasMoreTopRated: Bool { get }
    var hasMoreNowPlaying: Bool { get }
    var hasMoreUpcoming: Bool { get }

    // MARK: - Error

    var error: Error? { get }

    // MARK: - Public Methods

    func loadHome() async

    func loadNextTrendingPage() async
    func loadNextPopularPage() async
    func loadNextTopRatedPage() async
    func loadNextNowPlayingPage() async
    func loadNextUpcomingPage() async

    func loadVideos(for movie: Movie) async

    func clearError()
}

@MainActor
public final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Published Properties

    @Published public private(set) var trendingMovies: [Movie] = []

    @Published public private(set) var popularMovies: [Movie] = []

    @Published public private(set) var topRatedMovies: [Movie] = []

    @Published public private(set) var nowPlayingMovies: [Movie] = []

    @Published public private(set) var upcomingMovies: [Movie] = []

    @Published public private(set) var movieVideos: [Int: [MovieVideo]] = [:]

    @Published public private(set) var featuredItems: [FeaturedItem] = []

    // MARK: - Loading State

    @Published public private(set) var isTrendingLoading = false

    @Published public private(set) var isPopularLoading = false

    @Published public private(set) var isTopRatedLoading = false

    @Published public private(set) var isNowPlayingLoading = false

    @Published public private(set) var isUpcomingLoading = false

    // MARK: - Pagination State

    private var trendingPage = 1

    private var popularPage = 1

    private var topRatedPage = 1

    private var nowPlayingPage = 1

    private var upcomingPage = 1

    @Published public private(set) var hasMoreTrending = true

    @Published public private(set) var hasMorePopular = true

    @Published public private(set) var hasMoreTopRated = true

    @Published public private(set) var hasMoreNowPlaying = true

    @Published public private(set) var hasMoreUpcoming = true

    // MARK: - Error

    @Published public private(set) var error: Error?

    // MARK: - Dependencies

    private let fetchTrendingUseCase: FetchTrendingUseCaseProtocol

    private let fetchPopularUseCase: FetchPopularUseCaseProtocol

    private let fetchTopRatedUseCase: FetchTopRatedUseCaseProtocol

    private let fetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol

    private let fetchUpcomingUseCase: FetchUpcomingUseCaseProtocol

    private let fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol

    // MARK: - Initialization

    public init(
        fetchTrendingUseCase: FetchTrendingUseCaseProtocol,
        fetchPopularUseCase: FetchPopularUseCaseProtocol,
        fetchTopRatedUseCase: FetchTopRatedUseCaseProtocol,
        fetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol,
        fetchUpcomingUseCase: FetchUpcomingUseCaseProtocol,
        fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol
    ) {
        self.fetchTrendingUseCase = fetchTrendingUseCase
        self.fetchPopularUseCase = fetchPopularUseCase
        self.fetchTopRatedUseCase = fetchTopRatedUseCase
        self.fetchNowPlayingUseCase = fetchNowPlayingUseCase
        self.fetchUpcomingUseCase = fetchUpcomingUseCase
        self.fetchMovieVideosUseCase = fetchMovieVideosUseCase
    }

    // MARK: - Initial Loading

    public func loadHome() async {

        error = nil

        async let trending = loadNextTrendingPage()
        async let popular = loadNextPopularPage()
        async let topRated = loadNextTopRatedPage()
        async let nowPlaying = loadNextNowPlayingPage()
        async let upcoming = loadNextUpcomingPage()

        await (
            trending,
            popular,
            topRated,
            nowPlaying,
            upcoming
        )

        await loadFeaturedItems()
    }

    // MARK: - Trending

    public func loadNextTrendingPage() async {

        guard !isTrendingLoading, hasMoreTrending else {
            return
        }

        isTrendingLoading = true
        error = nil

        defer {
            isTrendingLoading = false
        }

        do {
            let page = try await fetchTrendingUseCase.execute(
                page: trendingPage
            )

            trendingMovies.append(
                contentsOf: page.movies
            )

            trendingPage = page.page + 1
            hasMoreTrending = page.hasNextPage

        } catch {
            self.error = error
        }
    }

    // MARK: - Popular

    public func loadNextPopularPage() async {

        guard !isPopularLoading, hasMorePopular else {
            return
        }

        isPopularLoading = true
        error = nil

        defer {
            isPopularLoading = false
        }

        do {
            let page = try await fetchPopularUseCase.execute(
                page: popularPage
            )

            popularMovies.append(
                contentsOf: page.movies
            )

            popularPage = page.page + 1
            hasMorePopular = page.hasNextPage

        } catch {
            self.error = error
        }
    }

    // MARK: - Top Rated

    public func loadNextTopRatedPage() async {

        guard !isTopRatedLoading, hasMoreTopRated else {
            return
        }

        isTopRatedLoading = true
        error = nil

        defer {
            isTopRatedLoading = false
        }

        do {
            let page = try await fetchTopRatedUseCase.execute(
                page: topRatedPage
            )

            topRatedMovies.append(
                contentsOf: page.movies
            )

            topRatedPage = page.page + 1
            hasMoreTopRated = page.hasNextPage

        } catch {
            self.error = error
        }
    }

    // MARK: - Now Playing

    public func loadNextNowPlayingPage() async {

        guard !isNowPlayingLoading, hasMoreNowPlaying else {
            return
        }

        isNowPlayingLoading = true
        error = nil

        defer {
            isNowPlayingLoading = false
        }

        do {
            let page = try await fetchNowPlayingUseCase.execute(
                page: nowPlayingPage
            )

            nowPlayingMovies.append(
                contentsOf: page.movies
            )

            nowPlayingPage = page.page + 1
            hasMoreNowPlaying = page.hasNextPage

        } catch {
            self.error = error
        }
    }

    // MARK: - Upcoming

    public func loadNextUpcomingPage() async {

        guard !isUpcomingLoading, hasMoreUpcoming else {
            return
        }

        isUpcomingLoading = true
        error = nil

        defer {
            isUpcomingLoading = false
        }

        do {
            let page = try await fetchUpcomingUseCase.execute(
                page: upcomingPage
            )

            upcomingMovies.append(
                contentsOf: page.movies
            )

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
            let videos = try await fetchMovieVideosUseCase.execute(
                movieID: movie.id
            )

            movieVideos[movie.id] = videos

        } catch {
            self.error = error
        }
    }

    // MARK: - Featured

    public func loadFeaturedItems() async {

        let movies = Array(
            nowPlayingMovies.prefix(5)
        )

        guard !movies.isEmpty else {
            featuredItems = []
            return
        }

        let items = await withTaskGroup(
            of: (Int, FeaturedItem?).self
        ) { group in

            for (index, movie) in movies.enumerated() {

                group.addTask {

                    do {
                        let videos = try await self.fetchMovieVideosUseCase
                            .execute(movieID: movie.id)

                        guard let video = await self.selectFeaturedVideo(
                            from: videos
                        ) else {
                            return (index, nil)
                        }

                        let item = FeaturedItem(
                            movie: movie,
                            video: video
                        )

                        return (index, item)

                    } catch {
                        return (index, nil)
                    }
                }
            }

            var results: [(Int, FeaturedItem)] = []

            for await (index, item) in group {

                if let item {
                    results.append(
                        (index, item)
                    )
                }
            }

            return results
                .sorted { $0.0 < $1.0 }
                .map(\.1)
        }

        featuredItems = items
    }

    // MARK: - Video Selection

    private func selectFeaturedVideo(
        from videos: [MovieVideo]
    ) -> MovieVideo? {

        let priority: [VideoType] = [
            .behindTheScenes,
            .trailer,
            .featurette,
            .bloopers
        ]

        for type in priority {

            if let officialVideo = videos.first(
                where: {
                    $0.type == type &&
                    $0.site == .youtube &&
                    $0.official
                }
            ) {
                return officialVideo
            }

            if let video = videos.first(
                where: {
                    $0.type == type &&
                    $0.site == .youtube
                }
            ) {
                return video
            }
        }

        return nil
    }

    // MARK: - Error Handling

    public func clearError() {
        error = nil
    }
}
