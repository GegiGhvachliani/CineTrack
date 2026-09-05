//
//  ActorImageDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorImageDTO: Decodable, Sendable {

    public let aspectRatio: Double
    public let filePath: String
    public let height: Int
    public let iso6391: String?
    public let voteAverage: Double
    public let voteCount: Int
    public let width: Int

    public init(
        aspectRatio: Double,
        filePath: String,
        height: Int,
        iso6391: String?,
        voteAverage: Double,
        voteCount: Int,
        width: Int
    ) {
        self.aspectRatio = aspectRatio
        self.filePath = filePath
        self.height = height
        self.iso6391 = iso6391
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.width = width
    }

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso6391 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
