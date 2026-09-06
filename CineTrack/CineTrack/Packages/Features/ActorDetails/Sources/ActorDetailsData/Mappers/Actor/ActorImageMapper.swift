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

    private let imageBaseURL = "https://image.tmdb.org/t/p/w780"

    public init() {}

    public func map(
        _ dto: ActorImageDTO
    ) -> ActorImage {

        ActorImage(
            id: dto.filePath,
            filePath: makeImageURL(from: dto.filePath),
            width: dto.width,
            height: dto.height,
            aspectRatio: dto.aspectRatio,
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount
        )
    }

    private func makeImageURL(from path: String) -> String {
        guard !path.isEmpty else {
            return ""
        }

        if path.hasPrefix("http") {
            return path
        }

        return "\(imageBaseURL)\(path)"
    }
}
