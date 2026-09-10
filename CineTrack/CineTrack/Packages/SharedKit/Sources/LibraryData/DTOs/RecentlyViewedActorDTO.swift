//
//  RecentlyViewedActorDTO.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import LibraryDomain

struct RecentlyViewedActorDTO: Codable, Sendable {

    // MARK: - Properties

    let id: Int
    let name: String
    let birthday: Date?
    let profilePath: String?
    let viewedAt: Date

    // MARK: - Initialization

    init(actor: RecentlyViewedActor) {
        self.id = actor.id
        self.name = actor.name
        self.birthday = actor.birthday
        self.profilePath = actor.profilePath
        self.viewedAt = actor.viewedAt
    }

    func toDomain() -> RecentlyViewedActor {

        RecentlyViewedActor(
            id: id,
            name: name,
            birthday: birthday,
            profilePath: profilePath,
            viewedAt: viewedAt
        )
    }
}
