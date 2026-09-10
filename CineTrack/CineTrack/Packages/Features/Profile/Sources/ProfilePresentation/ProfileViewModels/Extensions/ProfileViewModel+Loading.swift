//
//  ProfileViewModel+Loading.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import Foundation
import LibraryDomain
import Observation
import ProfileDomain
import SharedCore

extension ProfileViewModel {

    // MARK: - Loading

    public func load() async {
        guard !isLoading, !isSigningOut else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            async let profile = fetchProfileUseCase.execute()
            async let savedMovies = fetchWatchlistedMoviesUseCase.execute()
            async let savedActors = fetchFavouritedActorsUseCase.execute()
            async let recentMovies = fetchRecentlyViewedMoviesUseCase.execute()
            async let recentActors = fetchRecentlyViewedActorsUseCase.execute()
            let result = try await (profile, savedMovies, savedActors, recentMovies, recentActors)
            account = result.0
            movies = result.1
            actors = result.2
            recentlyViewed = (result.3.map(RecentlyViewedItem.movie) + result.4.map(RecentlyViewedItem.actor))
                .sorted { $0.viewedAt > $1.viewedAt }
            hasLoaded = true
        } catch is CancellationError {
            return
        } catch {
            errorMessage = error is ProfileError ? ProfileStrings.Content.invalidPhoto : error.localizedDescription
        }
    }
}
