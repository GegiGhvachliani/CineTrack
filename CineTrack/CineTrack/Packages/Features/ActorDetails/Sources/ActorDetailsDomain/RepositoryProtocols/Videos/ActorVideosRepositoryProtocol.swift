//
//  ActorVideosRepositoryProtocol.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SharedCore

public protocol ActorVideosRepositoryProtocol: Sendable {
    func fetchVideos(movieIDs: [Int]) async throws -> [ActorVideo]
}
