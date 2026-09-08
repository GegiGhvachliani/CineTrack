//
//  AddWatchlistedMovieUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SharedCore

public protocol AddWatchlistedMovieUseCaseProtocol: Sendable {
    func execute(_ movie: Movie) async throws
}

public final class AddWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol, @unchecked Sendable {
    private let repository: WatchlistRepositoryProtocol

    public init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ movie: Movie) async throws {
        try await repository.addWatchlistedMovie(movie)
    }
}
