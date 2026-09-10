//
//  SearchActorsUseCase.swift
//  Search
//

import SharedCore

public protocol SearchActorsUseCaseProtocol: Sendable {
    func execute(query: String, page: Int) async throws -> [Actor]
}

public struct SearchActorsUseCase: SearchActorsUseCaseProtocol {

    // MARK: - Properties

    private let repository: SearchRepositoryProtocol

    // MARK: - Initialization

    public init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(query: String, page: Int) async throws -> [Actor] {
        try await repository.searchActors(query: query, page: page)
    }
}
