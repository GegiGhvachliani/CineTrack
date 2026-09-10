//
//  ProfileViewModel+Actions.swift
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

    // MARK: - Favourites

    public func toggleFavourite(_ actor: Actor) async {
        guard !isSigningOut else { return }
        let key = "actor-\(actor.id)"
        guard pendingItems.insert(key).inserted else { return }
        defer { pendingItems.remove(key) }
        do {
            if actors.contains(where: { $0.id == actor.id }) {
                try await removeFavouritedActorUseCase.execute(actor: actor)
                actors.removeAll { $0.id == actor.id }
            } else {
                try await addFavouritedActorUseCase.execute(actor: actor)
                actors.insert(actor, at: 0)
            }
        } catch {
            errorMessage = error is ProfileError ? ProfileStrings.Content.invalidPhoto : error.localizedDescription
        }
    }
}
