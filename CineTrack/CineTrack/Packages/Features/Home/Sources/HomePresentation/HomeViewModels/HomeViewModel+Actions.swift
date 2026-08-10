//
//  HomeViewModel+Actions.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//


import Foundation

import HomeDomain
import SharedCore


extension HomeViewModel {

    // MARK: - Initial Loading

    public func loadHome() async {

        print("🔥 loadHome START")

        error = nil

        async let trendingTask =
            loadNextTrendingPage()

        async let popularTask =
            loadNextPopularPage()

        async let top10Task =
            loadTop10Movies()

        async let nowPlayingTask =
            loadNextNowPlayingPage()

        async let upcomingTask =
            loadNextUpcomingPage()

        async let bornTodayTask =
            loadNextBornTodayActorsPage()

        async let popularActorsTask =
            loadNextMostPopularCelebritiesPage()

        async let newsTask =
            loadNextNewsPage()

        await (
            trendingTask,
            popularTask,
            top10Task,
            nowPlayingTask,
            upcomingTask,
            bornTodayTask,
            popularActorsTask,
            newsTask
        )

        print("🔥 trending:", trendingMovies.count)
        print("🔥 popular:", popularMovies.count)
        print("🔥 top10:", top10Movies.count)
        print("🔥 nowPlaying:", nowPlayingMovies.count)
        print("🔥 upcoming:", upcomingMovies.count)
        print("🔥 bornToday:", bornTodayActors.count)
        print("🔥 actors:", mostPopularActors.count)
        print("🔥 news:", news.count)

        await loadFeaturedItems()

        print("🔥 featured:", featuredItems.count)
        
        print("🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️")
    }
    // MARK: - Trending

    public func loadNextTrendingPage() async {

        guard
            !isTrendingLoading,
            hasMoreTrending
        else {
            return
        }

        isTrendingLoading = true
        error = nil

        defer {
            isTrendingLoading = false
        }

        do {
            let page =
                try await fetchTrendingUseCase.execute(
                    page: trendingPage
                )

            trendingMovies.append(
                contentsOf: page.movies
            )

            trendingPage =
                page.page + 1

            hasMoreTrending =
                page.hasNextPage

        } catch {
            print("❌ Trending Error:", error)
            self.error = error
        }
    }

    // MARK: - Popular

    public func loadNextPopularPage() async {

        guard
            !isPopularLoading,
            hasMorePopular
        else {
            return
        }

        isPopularLoading = true
        error = nil

        defer {
            isPopularLoading = false
        }

        do {
            let page =
                try await fetchPopularUseCase.execute(
                    page: popularPage
                )

            popularMovies.append(
                contentsOf: page.movies
            )

            popularPage =
                page.page + 1

            hasMorePopular =
                page.hasNextPage

        } catch {
            self.error = error
        }
    }

    // MARK: - Top Rated

    public func loadNextTopRatedPage() async {

        guard
            !isTopRatedLoading,
            hasMoreTopRated
        else {
            return
        }

        isTopRatedLoading = true
        error = nil

        defer {
            isTopRatedLoading = false
        }

        do {
            let page =
                try await fetchTopRatedUseCase.execute(
                    page: topRatedPage
                )

            topRatedMovies.append(
                contentsOf: page.movies
            )

            topRatedPage =
                page.page + 1

            hasMoreTopRated =
                page.hasNextPage

        } catch {
            self.error = error
        }
    }

    // MARK: - Now Playing

    public func loadNextNowPlayingPage() async {

        guard
            !isNowPlayingLoading,
            hasMoreNowPlaying
        else {
            return
        }

        isNowPlayingLoading = true
        error = nil

        defer {
            isNowPlayingLoading = false
        }

        do {
            let page =
                try await fetchNowPlayingUseCase.execute(
                    page: nowPlayingPage
                )

            nowPlayingMovies.append(
                contentsOf: page.movies
            )

            nowPlayingPage =
                page.page + 1

            hasMoreNowPlaying =
                page.hasNextPage

        } catch {
            print("❌ Now Playing Error:", error)
            self.error = error
        }
    }

    // MARK: - Upcoming

    public func loadNextUpcomingPage() async {

        guard
            !isUpcomingLoading,
            hasMoreUpcoming
        else {
            return
        }

        isUpcomingLoading = true
        error = nil

        defer {
            isUpcomingLoading = false
        }

        do {
            let page =
                try await fetchUpcomingUseCase.execute(
                    page: upcomingPage
                )

            upcomingMovies.append(
                contentsOf: page.movies
            )

            upcomingPage =
                page.page + 1

            hasMoreUpcoming =
                page.hasNextPage

        } catch {
            self.error = error
        }
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
            let page =
                try await fetchBornTodayActorsUseCase.execute(
                    page: bornTodayActorsPage
                )

            bornTodayActors.append(
                contentsOf: page.actors
            )

            bornTodayActorsPage += 1

            hasMoreBornTodayActors =
                page.hasNextPage

        } catch {
            print("❌ Born Today Error:", error)
            self.error = error
        }
    }

    // MARK: - Most Popular Celebrities

    public func loadNextMostPopularCelebritiesPage() async {

        guard
            !isMostPopularCelebritiesLoading,
            hasMoreMostPopularCelebrities
        else {
            return
        }

        isMostPopularCelebritiesLoading = true

        defer {
            isMostPopularCelebritiesLoading = false
        }

        do {
            let page =
                try await fetchMostPopularActorsUseCase.execute(
                    page: mostPopularCelebritiesPage
                )

            mostPopularActors.append(
                contentsOf: page.actors
            )

            mostPopularCelebritiesPage += 1

            hasMoreMostPopularCelebrities =
                page.hasNextPage

        } catch {
            print("❌ Most Popular Actors Error:", error)
            self.error = error
        }
    }

    // MARK: - News

    public func loadNextNewsPage() async {

        guard
            !isNewsLoading,
            hasMoreNews
        else {
            return
        }

        isNewsLoading = true

        defer {
            isNewsLoading = false
        }

        do {
            let page =
                try await fetchNewsUseCase.execute(
                    page: newsPage
                )

            news.append(
                contentsOf: page.news
            )

            newsPage += 1

            hasMoreNews =
                news.count < page.totalResults

        } catch {
            print("❌ News Error:", error)

            self.error = error
        }
    }
    
    // MARK: - Top 10

    public func loadTop10Movies() async {

        guard top10Movies.isEmpty else {
            return
        }

        do {
            let page = try await fetchTopRatedUseCase.execute(
                page: 1
            )

            top10Movies = Array(
                page.movies.prefix(10)
            )

        } catch {
            print("❌ Top 10 Error:", error)
            self.error = error
        }
    }

    // MARK: - Videos

    public func loadVideos(
        for movie: Movie
    ) async {

        error = nil

        do {
            let videos =
                try await fetchMovieVideosUseCase.execute(
                    movieID: movie.id
                )

            movieVideos[movie.id] = videos

        } catch {
            self.error = error
        }
    }

    // MARK: - Watchlist

    public func toggleWatchlist(
        for movie: Movie
    ) {

        if watchlistedMovieIDs.contains(movie.id) {
            watchlistedMovieIDs.remove(movie.id)
        } else {
            watchlistedMovieIDs.insert(movie.id)
        }
    }

    // MARK: - Favourites

    public func toggleFavourite(
        for actor: Actor
    ) {

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
