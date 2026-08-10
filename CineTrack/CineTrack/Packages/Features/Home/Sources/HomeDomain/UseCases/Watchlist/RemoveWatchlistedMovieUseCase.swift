//
//  RemoveWatchlistedMovieUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

public protocol RemoveWatchlistedMovieUseCaseProtocol: Sendable {

    func execute(
        movieID: Int
    ) async throws
}

public final class RemoveWatchlistedMovieUseCase:
    RemoveWatchlistedMovieUseCaseProtocol,
    @unchecked Sendable
{
    private let repository: WatchlistRepositoryProtocol

    public init(
        repository: WatchlistRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        movieID: Int
    ) async throws {

        try await repository.removeWatchlistedMovie(
            id: movieID
        )
    }
}
