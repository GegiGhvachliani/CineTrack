//
//  HomeViewModel+RecentlyViewed.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import LibraryDomain

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Load

    public func loadRecentlyViewed() async {

        guard !isRecentlyViewedLoading else { return }

        isRecentlyViewedLoading = true

        defer { isRecentlyViewedLoading = false }

        do {

            async let movies = fetchRecentlyViewedMoviesUseCase.execute()

            async let actors = fetchRecentlyViewedActorsUseCase.execute()

            recentlyViewedMovies = try await movies

            recentlyViewedActors = try await actors

        } catch {
            print("❌ Recently Viewed Error:", error)
            self.error = error
        }
    }

    // MARK: - Clear

    public func clearRecentlyViewed() async {

        do {

            try await clearRecentlyViewedUseCase.execute()

            recentlyViewedMovies = []
            recentlyViewedActors = []

        } catch {
            print("❌ Clear Recently Viewed Error:", error)
            self.error = error
        }
    }
}
