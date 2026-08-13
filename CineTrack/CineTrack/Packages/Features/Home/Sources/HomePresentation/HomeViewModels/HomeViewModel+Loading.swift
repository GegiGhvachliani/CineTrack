//
//  HomeViewModel+Loading.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

//
//  HomeViewModel+Loading.swift
//  Home
//

import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    public func loadHome() async {

        guard isHomeLoading else {
            return
        }

        error = nil
        isHomeLoading = true

        defer {
            isHomeLoading = false
        }

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

        await loadFeaturedItems()
    }
}
