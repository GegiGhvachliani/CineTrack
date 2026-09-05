//
//  ActorExternalLinks.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorExternalLinks: Equatable, Sendable {

    // MARK: - Social

    public let facebookID: String?
    public let instagramID: String?
    public let tiktokID: String?
    public let twitterID: String?
    public let youtubeID: String?

    // MARK: - External

    public let imdbID: String?
    public let wikidataID: String?

    // MARK: - Init

    public init(
        facebookID: String?,
        instagramID: String?,
        tiktokID: String?,
        twitterID: String?,
        youtubeID: String?,
        imdbID: String?,
        wikidataID: String?
    ) {
        self.facebookID = facebookID
        self.instagramID = instagramID
        self.tiktokID = tiktokID
        self.twitterID = twitterID
        self.youtubeID = youtubeID
        self.imdbID = imdbID
        self.wikidataID = wikidataID
    }
}
