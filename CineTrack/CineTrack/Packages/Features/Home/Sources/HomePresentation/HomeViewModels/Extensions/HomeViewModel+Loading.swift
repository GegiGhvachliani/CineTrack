//
//  HomeViewModel+Loading.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//


import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Visible section recovery

    public func restoreVisibleSections() async {
        async let trendingTask: Void = loadTrendingIfNeeded()
        async let fanFavouritesTask: Void = loadFanFavouritesIfNeeded()
        async let nowPlayingTask: Void = loadNowPlayingIfNeeded()
        async let upcomingTask: Void = loadUpcomingIfNeeded()
        async let top10Task: Void = loadTop10IfNeeded()
        async let bornTodayTask: Void = loadBornTodayIfNeeded()
        async let popularActorsTask: Void = loadPopularActorsIfNeeded()
        async let newsTask: Void = loadNewsIfNeeded()

        await (
            trendingTask,
            fanFavouritesTask,
            nowPlayingTask,
            upcomingTask,
            top10Task,
            bornTodayTask,
            popularActorsTask,
            newsTask
        )
    }

    public func loadHome() async {
        guard !isHomeLoading, !hasLoadedInitialHome else {
            return
        }

        isHomeLoading = true
        error = nil

        defer {
            isHomeLoading = false
            hasLoadedInitialHome = true
        }

        async let trendingTask = loadNextTrendingPage()
        async let popularTask = loadNextPopularPage()
        async let fanFavouritesTask = loadNextFanFavouritePage()
        async let top10Task = loadTop10Movies()
        async let nowPlayingTask = loadNextNowPlayingPage()
        async let upcomingTask = loadNextUpcomingPage()
        async let bornTodayTask = loadNextBornTodayActorsPage()
        async let popularActorsTask = loadNextMostPopularCelebritiesPage()
        async let newsTask = loadNextNewsPage()
        async let recentlyViewedTask = loadRecentlyViewed()
        async let watchlistTask = loadWatchlist()
        async let favouritesTask = loadFavourites()

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

        await loadFeaturedItems()
    }

    // MARK: - Empty section loading

    private func loadTrendingIfNeeded() async {
        guard trendingMovies.isEmpty else { return }
        await loadNextTrendingPage()
    }

    private func loadFanFavouritesIfNeeded() async {
        guard fanFavouriteMovies.isEmpty else { return }
        await loadNextFanFavouritePage()
    }

    private func loadNowPlayingIfNeeded() async {
        guard nowPlayingMovies.isEmpty else { return }
        await loadNextNowPlayingPage()
    }

    private func loadUpcomingIfNeeded() async {
        guard upcomingMovies.isEmpty else { return }
        await loadNextUpcomingPage()
    }

    private func loadTop10IfNeeded() async {
        guard top10Movies.isEmpty else { return }
        await loadTop10Movies()
    }

    private func loadBornTodayIfNeeded() async {
        guard bornTodayActors.isEmpty else { return }
        await loadNextBornTodayActorsPage()
    }

    private func loadPopularActorsIfNeeded() async {
        guard mostPopularActors.isEmpty else { return }
        await loadNextMostPopularCelebritiesPage()
    }

    private func loadNewsIfNeeded() async {
        guard news.isEmpty else { return }
        await loadNextNewsPage()
    }
}
