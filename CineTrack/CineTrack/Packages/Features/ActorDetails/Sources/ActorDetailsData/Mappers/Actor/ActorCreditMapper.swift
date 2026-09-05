//
//  ActorCreditMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import TMDBData
import ActorDetailsDomain

public struct ActorCreditMapper: Sendable {

    public init() {}

    public func map(
        _ dto: ActorCreditDTO
    ) -> ActorCredit {
        ActorCredit(
            id: dto.id,
            creditID: dto.creditID,
            title: dto.title,
            posterPath: dto.posterPath,
            backdropPath: dto.backdropPath,
            releaseDate: dto.releaseDate,
            character: dto.character,
            order: dto.order
        )
    }
}
