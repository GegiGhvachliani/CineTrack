//
//  FetchMovieVideosUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import Foundation
import SharedCore

public protocol FetchMovieVideosUseCaseProtocol: Sendable {

    func execute(movieID: Int) async throws -> [MovieVideo]
}

public final class FetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol {

    // MARK: - Properties

    private let repository: HomeRepositoryProtocol

    // MARK: - Initialization

    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> [MovieVideo] {
        try await repository.fetchVideos(movieId: movieID)
    }
}
