//
//  ActorCreditDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorCreditDTO: Decodable, Sendable {

    public let id: Int
    public let backdropPath: String?
    public let character: String?
    public let creditID: String?
    public let genreIDs: [Int]
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double
    public let posterPath: String?
    public let releaseDate: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    public let order: Int?

    public init(
        id: Int,
        backdropPath: String?,
        character: String?,
        creditID: String?,
        genreIDs: [Int],
        originalLanguage: String?,
        originalTitle: String?,
        overview: String?,
        popularity: Double,
        posterPath: String?,
        releaseDate: String?,
        title: String,
        video: Bool,
        voteAverage: Double,
        voteCount: Int,
        order: Int?
    ) {
        self.id = id
        self.backdropPath = backdropPath
        self.character = character
        self.creditID = creditID
        self.genreIDs = genreIDs
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.order = order
    }

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case character
        case creditID = "credit_id"
        case genreIDs = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case order
    }
}
