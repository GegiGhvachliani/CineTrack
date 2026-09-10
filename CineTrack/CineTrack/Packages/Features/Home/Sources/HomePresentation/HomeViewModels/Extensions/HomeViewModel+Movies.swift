//
//  HomeViewModel+Movies.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//

import Foundation
import LibraryDomain

import HomeDomain
import SharedCore

extension HomeViewModel {

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
            print("❌ Trending Error:", error)
            self.error = error
        }
    }

    // MARK: - Popular

    public func loadNextPopularPage() async {

        guard !isPopularLoading, hasMorePopular else { return }

        isPopularLoading = true
        error = nil

        defer {
            isPopularLoading = false
        }

        do {
            let page = try await fetchPopularUseCase.execute(page: popularPage)

            popularMovies.append(contentsOf: page.movies)

            popularPage = page.page + 1

            hasMorePopular = page.hasNextPage

        } catch {
            print("❌ Popular Error:", error)
            self.error = error
        }
    }

    // MARK: - Fan Favourites

    public func loadNextFanFavouritePage() async {

        guard !isFanFavouriteLoading, hasMoreFanFavourite else { return }

        isFanFavouriteLoading = true
        error = nil

        defer {
            isFanFavouriteLoading = false
        }

        do {
            let page = try await fetchFanFavouritesUseCase.execute(page: fanFavouritePage)

            fanFavouriteMovies.append(contentsOf: page.movies)

            fanFavouritePage = page.page + 1

            hasMoreFanFavourite = page.hasNextPage

        } catch {
            print("❌ Fan Favourites Error:", error)
            self.error = error
        }
    }

    // MARK: - Now Playing

    public func loadNextNowPlayingPage() async {

        guard !isNowPlayingLoading, hasMoreNowPlaying else { return }

        isNowPlayingLoading = true
        error = nil

        defer {
            isNowPlayingLoading = false
        }

        do {

            let page = try await fetchNowPlayingUseCase.execute(page: nowPlayingPage)

            nowPlayingMovies.append(contentsOf: page.movies)

            nowPlayingPage = page.page + 1

            hasMoreNowPlaying = page.hasNextPage

        } catch {
            print("❌ Now Playing Error:", error)
            self.error = error
        }
    }

    // MARK: - Upcoming

    public func loadNextUpcomingPage() async {

        guard !isUpcomingLoading, hasMoreUpcoming else { return }

        isUpcomingLoading = true
        error = nil

        defer {
            isUpcomingLoading = false
        }

        do {
            let page = try await fetchUpcomingUseCase.execute(page: upcomingPage)

            upcomingMovies.append(contentsOf: page.movies)

            upcomingPage = page.page + 1

            hasMoreUpcoming = page.hasNextPage

        } catch {
            print("❌ Upcoming Error:", error)
            self.error = error
        }
    }

    // MARK: - Top 10

    public func loadTop10Movies() async {

        guard !isTop10Loading, top10Movies.isEmpty else { return }

        isTop10Loading = true
        error = nil

        defer {
            isTop10Loading = false
        }

        do {

            top10Movies = try await fetchTop10MoviesUseCase.execute()

        } catch {
            print("❌ Top 10 Error:", error)
            self.error = error
        }
    }
}
