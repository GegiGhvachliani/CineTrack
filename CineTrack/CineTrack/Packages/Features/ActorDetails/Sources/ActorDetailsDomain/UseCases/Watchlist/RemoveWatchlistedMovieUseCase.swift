//
//  RemoveWatchlistedMovieUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SharedCore

public protocol RemoveWatchlistedMovieUseCaseProtocol: Sendable {
    func execute(_ movie: Movie) async throws
}

public final class RemoveWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol, @unchecked Sendable {
    private let repository: WatchlistRepositoryProtocol

    public init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ movie: Movie) async throws {
        try await repository.removeWatchlistedMovie(movie)
    }
}
