//
//  FavouritedActorDTO.swift
//  Home
//
//  Created by Gegi Ghvachliani on 12/08/2026.
//

import Foundation
import SharedCore

struct FavouritedActorDTO: Codable, Sendable {

    let id: Int
    let name: String
    let birthday: Date?
    let profilePath: String?
    let favouritedAt: Date?

    init(actor: Actor) {
        self.id = actor.id
        self.name = actor.name
        self.birthday = actor.birthday
        self.profilePath = actor.profilePath
        self.favouritedAt = .now
    }

    func toDomain() -> Actor {

        Actor(
            id: id,
            name: name,
            birthday: birthday,
            profilePath: profilePath
        )
    }
}
