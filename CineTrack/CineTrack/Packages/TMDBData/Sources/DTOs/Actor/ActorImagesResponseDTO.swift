//
//  ActorImagesResponseDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorImagesResponseDTO: Decodable, Sendable {

    // MARK: - Properties

    public let id: Int
    public let profiles: [ActorImageDTO]

    // MARK: - Initialization

    public init(
        id: Int,
        profiles: [ActorImageDTO]
    ) {
        self.id = id
        self.profiles = profiles
    }
}
