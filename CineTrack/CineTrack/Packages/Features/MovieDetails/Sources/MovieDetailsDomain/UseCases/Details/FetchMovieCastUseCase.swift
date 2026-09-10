//
//  FetchMovieCastUseCase.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

public protocol FetchMovieCastUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> [MovieCastMember]
}

public struct FetchMovieCastUseCase: FetchMovieCastUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> [MovieCastMember] {
        try await repository.fetchCast(movieID: movieID)
    }
}
