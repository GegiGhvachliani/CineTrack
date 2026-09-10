//
//  MovieVideoMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import Foundation
import SharedCore

public struct MovieVideoMapper: Sendable {

    // MARK: - Initialization

    public init() {}

    public func map(_ dto: MovieVideoDTO) -> MovieVideo {
        MovieVideo(
            id: dto.id,
            key: dto.key,
            name: dto.name,
            site: mapSite(dto.site),
            type: mapType(dto.type),
            official: dto.official
        )
    }

    public func map(
        _ response: MovieVideosResponseDTO
    ) -> [MovieVideo] {
        response.results.map(map)
    }

    private func mapSite(
        _ site: String
    ) -> VideoSite {
        VideoSite(rawValue: site) ?? .unknown
    }

    private func mapType(
        _ type: String
    ) -> VideoType {
        VideoType(rawValue: type) ?? .unknown
    }
}
