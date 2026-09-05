//
//  ActorCreditsResponseDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorCreditsResponseDTO: Decodable, Sendable {

    public let id: Int
    public let cast: [ActorCreditDTO]
    public let crew: [ActorCreditDTO]

    public init(
        id: Int,
        cast: [ActorCreditDTO],
        crew: [ActorCreditDTO]
    ) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}
