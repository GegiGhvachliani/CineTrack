//
//  ActorDetailsViewModel+Favourites.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import LibraryDomain
import Observation
import ActorDetailsDomain
import SharedCore

extension ActorDetailsViewModel {

    // MARK: - Favourites

    public func toggleFavourite() async {
        guard let actor, pendingFavouriteIDs.insert(actor.id).inserted else {
            return
        }

        defer {
            pendingFavouriteIDs.remove(actor.id)
        }

        let sharedActor = Actor(
            id: actor.id,
            name: actor.name,
            birthday: actor.birthday,
            profilePath: actor.profileURL?.absoluteString ?? actor.profilePath
        )
        let wasFavourite = favouritedActorIDs.contains(actor.id)

        if wasFavourite {
            favouritedActorIDs.remove(actor.id)
        } else {
            favouritedActorIDs.insert(actor.id)
        }

        do {
            if wasFavourite {
                try await removeFavouritedActorUseCase.execute(actor: sharedActor)
            } else {
                try await addFavouritedActorUseCase.execute(actor: sharedActor)
            }
        } catch {
            if wasFavourite {
                favouritedActorIDs.insert(actor.id)
            } else {
                favouritedActorIDs.remove(actor.id)
            }
            sectionErrors[.favourites] = error
        }
    }
}
