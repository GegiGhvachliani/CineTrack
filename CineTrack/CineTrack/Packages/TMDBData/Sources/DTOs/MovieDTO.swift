//
//  MovieDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public struct MovieDTO: Decodable {

    public let id: Int
    public let title: String
    public let overview: String?
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
