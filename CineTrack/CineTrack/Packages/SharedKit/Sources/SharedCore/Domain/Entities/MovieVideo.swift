//
//  MovieVideo.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import Foundation

public struct MovieVideo: Identifiable, Equatable, Sendable {

    public let id: String
    public let key: String
    public let name: String
    public let site: VideoSite
    public let type: VideoType
    public let official: Bool

    public init(
        id: String,
        key: String,
        name: String,
        site: VideoSite,
        type: VideoType,
        official: Bool
    ) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
        self.type = type
        self.official = official
    }
}
