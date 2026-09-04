//
//  HomeViewModel+FavouriteActorMovies.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/09/2026.
//


import Foundation
import SharedCore

extension HomeViewModel {
    public func loadFavouriteActorMovies() async {
        
        guard let actor = favouritedActors.randomElement() else {
            print("⚠️ No favourite actor available for the section")
            selectedFavouriteActor = nil
            selectedFavouriteActorMovies = []
            return
        }

        print("✅ Selected favourite actor:", actor.name)

        selectedFavouriteActor = actor

        do {
            selectedFavouriteActorMovies = try await fetchActorMoviesUseCase.execute(actorID: actor.id)
        } catch {
            print("❌ Actor movies error:", error)
            self.error = error
            selectedFavouriteActorMovies = []
        }
    }
}
