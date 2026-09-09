//
//  3.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

public protocol FetchPlaylistVideosUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> [MovieVideo]
}

public struct FetchPlaylistVideosUseCase: FetchPlaylistVideosUseCaseProtocol {
    private let repository: VideosListRepositoryProtocol

    public init(repository: VideosListRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> [MovieVideo] {
        try await repository.fetchVideos(movieID: movieID)
    }
}
