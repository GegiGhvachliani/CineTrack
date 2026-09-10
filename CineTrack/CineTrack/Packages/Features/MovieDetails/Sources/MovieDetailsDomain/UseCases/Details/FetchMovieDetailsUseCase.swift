//
//  FetchMovieDetailsUseCase.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

public protocol FetchMovieDetailsUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> MovieDetails
}

public struct FetchMovieDetailsUseCase: FetchMovieDetailsUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> MovieDetails {
        try await repository.fetchMovieDetails(movieID: movieID)
    }
}
