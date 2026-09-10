//
//  DiscoverMoviesUseCase.swift
//  Search
//

import SharedCore

public protocol DiscoverMoviesUseCaseProtocol: Sendable {
    func execute(filters: SearchFilters, page: Int) async throws -> [Movie]
}

public struct DiscoverMoviesUseCase: DiscoverMoviesUseCaseProtocol {

    // MARK: - Properties

    private let repository: SearchRepositoryProtocol

    // MARK: - Initialization

    public init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(filters: SearchFilters, page: Int) async throws -> [Movie] {
        try await repository.discoverMovies(filters: filters, page: page)
    }
}
