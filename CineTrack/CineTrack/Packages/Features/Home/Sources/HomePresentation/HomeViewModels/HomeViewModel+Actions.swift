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

        async let fanFavouritesTask =
            loadNextFanFavouritePage()

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
        
        async let recentlyViewedTask =
            loadRecentlyViewed()
        
        async let watchlistTask =
            loadWatchlist()

        async let favouritesTask =
            loadFavourites()

        await (
            trendingTask,
            popularTask,
            fanFavouritesTask,
            top10Task,
            nowPlayingTask,
            upcomingTask,
            bornTodayTask,
            popularActorsTask,
            newsTask,
            recentlyViewedTask,
            watchlistTask,
            favouritesTask
        )
        print("🔥 trending:", trendingMovies.count)
        print("🔥 popular:", popularMovies.count)
        print("🔥 fan favourites:", fanFavouriteMovies.count)
        print("🔥 top 10:", top10Movies.count)
        print("🔥 now playing:", nowPlayingMovies.count)
        print("🔥 upcoming:", upcomingMovies.count)
        print("🔥 born today:", bornTodayActors.count)
        print("🔥 actors:", mostPopularActors.count)
        print("🔥 news:", news.count)

        await loadFeaturedItems()

        print("🔥 featured:", featuredItems.count)

        print(
            "🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️"
        )
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
            print("❌ Popular Error:", error)
            self.error = error
        }
    }

    // MARK: - Fan Favourites

    public func loadNextFanFavouritePage() async {

        guard
            !isFanFavouriteLoading,
            hasMoreFanFavourite
        else {
            return
        }

        isFanFavouriteLoading = true
        error = nil

        defer {
            isFanFavouriteLoading = false
        }

        do {
            let page =
                try await fetchFanFavouritesUseCase.execute(
                    page: fanFavouritePage
                )

            fanFavouriteMovies.append(
                contentsOf: page.movies
            )

            fanFavouritePage =
                page.page + 1

            hasMoreFanFavourite =
                page.hasNextPage

        } catch {
            print("❌ Fan Favourites Error:", error)
            self.error = error
        }
    }

    // MARK: - Top 10

    public func loadTop10Movies() async {

        guard
            !isTop10Loading,
            top10Movies.isEmpty
        else {
            return
        }

        isTop10Loading = true
        error = nil

        defer {
            isTop10Loading = false
        }

        do {
            top10Movies =
                try await fetchTop10MoviesUseCase.execute()

        } catch {
            print("❌ Top 10 Error:", error)
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
            print("❌ Upcoming Error:", error)
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

    // MARK: - Videos

    public func loadVideos(for movie: Movie) async {

    error = nil

    do {
        let videos =
            try await fetchMovieVideosUseCase.execute(
                movieID: movie.id
            )

        movieVideos[movie.id] = videos

    } catch {
        print("❌ Videos Error:", error)
        self.error = error
    }
}

    // MARK: - Watchlist

    public func loadWatchlist() async {

        do {
            watchlistedMovieIDs =
                try await fetchWatchlistedMovieIDsUseCase
                    .execute()

        } catch {
            print(
                "❌ Watchlist Load Error:",
                error
            )

            self.error = error
        }
    }

    // MARK: - Watchlist

    public func toggleWatchlist(
        for movie: Movie
    ) async {

        let movieID = movie.id

        let wasWatchlisted =
            watchlistedMovieIDs.contains(movieID)

        // Optimistic UI update
        if wasWatchlisted {
            watchlistedMovieIDs.remove(movieID)
        } else {
            watchlistedMovieIDs.insert(movieID)
        }

        do {

            if wasWatchlisted {

                try await removeWatchlistedMovieUseCase
                    .execute(
                        movieID: movieID
                    )

            } else {

                try await addWatchlistedMovieUseCase
                    .execute(
                        movieID: movieID
                    )
            }

        } catch {

            // Rollback optimistic UI update
            if wasWatchlisted {
                watchlistedMovieIDs.insert(movieID)
            } else {
                watchlistedMovieIDs.remove(movieID)
            }

            self.error = error
        }
    }


    // MARK: - Favourites

    public func loadFavourites() async {

        do {
            favouritedActorIDs =
                try await fetchFavouritedActorIDsUseCase
                    .execute()

        } catch {
            print(
                "❌ Favourites Load Error:",
                error
            )

            self.error = error
        }
    }

    public func toggleFavourite(
        for actor: Actor
    ) async {

        let actorID = actor.id

        let wasFavourited =
            favouritedActorIDs.contains(actorID)

        // Optimistic UI update

        if wasFavourited {
            favouritedActorIDs.remove(actorID)
        } else {
            favouritedActorIDs.insert(actorID)
        }

        do {

            if wasFavourited {

                try await removeFavouritedActorUseCase
                    .execute(
                        actorID: actorID
                    )

            } else {

                try await addFavouritedActorUseCase
                    .execute(
                        actorID: actorID
                    )
            }

        } catch {

            // Rollback

            if wasFavourited {
                favouritedActorIDs.insert(actorID)
            } else {
                favouritedActorIDs.remove(actorID)
            }

            print(
                "❌ Favourite Toggle Error:",
                error
            )

            self.error = error
        }
    }

    // MARK: - Error Handling

    public func clearError() {
        error = nil
    }
}
