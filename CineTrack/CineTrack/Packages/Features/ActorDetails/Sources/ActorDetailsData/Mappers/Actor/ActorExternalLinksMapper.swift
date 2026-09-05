//
//  ActorExternalLinksMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import TMDBData
import ActorDetailsDomain

public struct ActorExternalLinksMapper: Sendable {

    public init() {}

    public func map(
        _ dto: ActorExternalIDsDTO
    ) -> ActorExternalLinks {
        ActorExternalLinks(
            facebookID: dto.facebookID,
            instagramID: dto.instagramID,
            tiktokID: dto.tiktokID,
            twitterID: dto.twitterID,
            youtubeID: dto.youtubeID,
            imdbID: dto.imdbID,
            wikidataID: dto.wikidataID
        )
    }
}
