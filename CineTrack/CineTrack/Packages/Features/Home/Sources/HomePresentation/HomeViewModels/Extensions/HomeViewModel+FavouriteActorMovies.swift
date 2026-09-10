//
//  HomeViewModel+FavouriteActorMovies.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/09/2026.
//

import Foundation
import LibraryDomain
import SharedCore

extension HomeViewModel {
    public func loadFavouriteActorMovies() async {

        guard let actor = favouritedActors.first else {
            print("⚠️ No favourite actor available for the section")
            selectedFavouriteActor = nil
            selectedFavouriteActorMovies = []
            return
        }

        selectedFavouriteActor = actor

        do {
            let movies = try await fetchActorMoviesUseCase.execute(
                actorID: actor.id
            )

            guard selectedFavouriteActor?.id == actor.id else {
                return
            }

            selectedFavouriteActorMovies = movies
        } catch {
            guard selectedFavouriteActor?.id == actor.id else {
                return
            }

            self.error = error
        }
    }
}
