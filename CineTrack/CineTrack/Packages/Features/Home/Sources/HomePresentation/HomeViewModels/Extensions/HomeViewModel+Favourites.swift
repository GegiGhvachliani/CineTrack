//
//  HomeViewModel+Favourites.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//


import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

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

            favouritedActors.append(actor)
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
                favouritedActors.append(actor)
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
