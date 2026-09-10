//
//  ActorExternalIDsDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorExternalIDsDTO: Decodable, Sendable {

    // MARK: - Properties

    public let id: Int
    public let facebookID: String?
    public let instagramID: String?
    public let tiktokID: String?
    public let twitterID: String?
    public let youtubeID: String?
    public let imdbID: String?
    public let wikidataID: String?

    // MARK: - Initialization

    public init(
        id: Int,
        facebookID: String?,
        instagramID: String?,
        tiktokID: String?,
        twitterID: String?,
        youtubeID: String?,
        imdbID: String?,
        wikidataID: String?
    ) {
        self.id = id
        self.facebookID = facebookID
        self.instagramID = instagramID
        self.tiktokID = tiktokID
        self.twitterID = twitterID
        self.youtubeID = youtubeID
        self.imdbID = imdbID
        self.wikidataID = wikidataID
    }

    enum CodingKeys: String, CodingKey {
        case id
        case facebookID = "facebook_id"
        case instagramID = "instagram_id"
        case tiktokID = "tiktok_id"
        case twitterID = "twitter_id"
        case youtubeID = "youtube_id"
        case imdbID = "imdb_id"
        case wikidataID = "wikidata_id"
    }
}
