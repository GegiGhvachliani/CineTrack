//
//  FetchActorMoviesUseCaseProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/09/2026.
//

import SharedCore

public protocol FetchActorMoviesUseCaseProtocol: Sendable {
    func execute(actorID: Int) async throws -> [Movie]
}

public final class FetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol {
    private let repository: HomeRepositoryProtocol

    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(actorID: Int) async throws -> [Movie] {
        try await repository.fetchMovies(for: actorID)
    }
}
