//
//  ActorImagesResponseDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorImagesResponseDTO: Decodable, Sendable {

    public let id: Int
    public let profiles: [ActorImageDTO]

    public init(
        id: Int,
        profiles: [ActorImageDTO]
    ) {
        self.id = id
        self.profiles = profiles
    }
}
