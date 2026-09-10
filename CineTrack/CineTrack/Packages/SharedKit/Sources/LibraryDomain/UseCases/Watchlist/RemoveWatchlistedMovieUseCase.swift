//
//  RemoveWatchlistedMovieUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

import SharedCore

public protocol RemoveWatchlistedMovieUseCaseProtocol: Sendable {

    func execute(movie: Movie) async throws
}

public final class RemoveWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: WatchlistRepositoryProtocol

    // MARK: - Initialization

    public init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movie: Movie) async throws {

        try await repository.removeWatchlistedMovie(movie: movie)
    }
}
