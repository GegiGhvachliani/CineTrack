//
//  AddWatchlistedMovieUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

public protocol AddWatchlistedMovieUseCaseProtocol: Sendable {

    func execute(
        movieID: Int
    ) async throws
}

public final class AddWatchlistedMovieUseCase:
    AddWatchlistedMovieUseCaseProtocol,
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

        try await repository.addWatchlistedMovie(
            id: movieID
        )
    }
}
