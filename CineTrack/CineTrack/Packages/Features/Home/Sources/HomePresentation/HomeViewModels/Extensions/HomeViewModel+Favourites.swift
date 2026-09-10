//
//  HomeViewModel+Favourites.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//

import Foundation
import LibraryDomain

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Refresh

    public func refreshPersonalizedContent() async {
        async let watchlistTask: Void = loadWatchlist()
        async let favouritesTask: Void = loadFavourites()
        async let recentlyViewedTask: Void = loadRecentlyViewed()

        await watchlistTask
        await favouritesTask
        await recentlyViewedTask
    }

    // MARK: - Load

    public func loadFavourites() async {
        do {
            favouritedActors = try await fetchFavouritedActorsUseCase.execute()

            print("✅ Loaded favourite actors:", favouritedActors.count)

            await loadFavouriteActorMovies()
        } catch {
            print("❌ Favourites Load Error:", error)
            self.error = error
        }
    }

    // MARK: - Toggle

    public func toggleFavourite(for actor: Actor) async {

        guard pendingFavouriteIDs.insert(actor.id).inserted else {
            return
        }

        defer {
            pendingFavouriteIDs.remove(actor.id)
        }

        let wasFavourited = favouritedActors.contains {
            $0.id == actor.id
        }

        if wasFavourited {

            favouritedActors.removeAll { $0.id == actor.id }

        } else {

            favouritedActors.insert(actor, at: 0)
        }

        do {
            if wasFavourited {
                try await removeFavouritedActorUseCase.execute(actor: actor)
            } else {
                try await addFavouritedActorUseCase.execute(actor: actor)
            }

            await loadFavouriteActorMovies()
        } catch {
            if wasFavourited {
                favouritedActors.insert(actor, at: 0)
            } else {
                favouritedActors.removeAll {
                    $0.id == actor.id
                }
            }

            print("❌ Favourite Toggle Error:", error)
            self.error = error
        }
    }
}
