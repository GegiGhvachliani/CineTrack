//
//  ActorImageMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import TMDBData
import ActorDetailsDomain

public struct ActorImageMapper: Sendable {

    public init() {}

    public func map(
        _ dto: ActorImageDTO
    ) -> ActorImage {
        ActorImage(
            id: dto.filePath,
            filePath: dto.filePath,
            width: dto.width,
            height: dto.height,
            aspectRatio: dto.aspectRatio,
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount
        )
    }
}
