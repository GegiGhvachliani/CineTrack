//
//  1.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

public protocol VideosListRepositoryProtocol: Sendable {
    func fetchVideos(movieID: Int) async throws -> [MovieVideo]
}
