//
//  ActorVideo.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SharedCore

public struct ActorVideo: Identifiable, Equatable, Sendable {

    // MARK: - Properties

    public let movieID: Int
    public let video: MovieVideo

    public var id: String {
        "\(movieID)-\(video.id)"
    }

    // MARK: - Initialization

    public init(movieID: Int, video: MovieVideo) {
        self.movieID = movieID
        self.video = video
    }
}
