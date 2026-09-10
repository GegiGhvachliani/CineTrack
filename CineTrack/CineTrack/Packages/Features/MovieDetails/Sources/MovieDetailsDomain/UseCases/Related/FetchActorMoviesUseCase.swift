//
//  FetchActorMoviesUseCase.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

public protocol FetchActorMoviesUseCaseProtocol: Sendable {
    func execute(actorID: Int) async throws -> [Movie]
}

public struct FetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(actorID: Int) async throws -> [Movie] {
        try await repository.fetchMovies(for: actorID)
    }
}
