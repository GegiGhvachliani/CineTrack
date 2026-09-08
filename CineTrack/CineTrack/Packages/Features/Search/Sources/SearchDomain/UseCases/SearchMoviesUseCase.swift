//
//  SearchMoviesUseCase.swift
//  Search
//

import SharedCore

public protocol SearchMoviesUseCaseProtocol: Sendable {
    func execute(query: String, page: Int) async throws -> [Movie]
}

public struct SearchMoviesUseCase: SearchMoviesUseCaseProtocol {

    private let repository: SearchRepositoryProtocol

    public init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(query: String, page: Int) async throws -> [Movie] {
        try await repository.searchMovies(query: query, page: page)
    }
}
