//
//  FetchWatchlistedMovieIDsUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

public protocol FetchWatchlistedMovieIDsUseCaseProtocol: Sendable {

    func execute() async throws -> Set<Int>
}

public final class FetchWatchlistedMovieIDsUseCase:
    FetchWatchlistedMovieIDsUseCaseProtocol,
    @unchecked Sendable
{
    private let repository: WatchlistRepositoryProtocol

    public init(
        repository: WatchlistRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute() async throws -> Set<Int> {
        try await repository.fetchWatchlistedMovieIDs()
    }
}
