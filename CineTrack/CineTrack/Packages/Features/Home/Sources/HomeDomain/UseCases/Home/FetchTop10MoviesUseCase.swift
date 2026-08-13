//
//  FetchTop10MoviesUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation
import HomeDomain
import SharedCore

public protocol FetchTop10MoviesUseCaseProtocol: Sendable {

    func execute() async throws -> [Movie]
}

public final class FetchTop10MoviesUseCase: FetchTop10MoviesUseCaseProtocol {

    private let repository: HomeRepositoryProtocol

    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> [Movie] {

        let page = try await repository.fetchTopRated(page: 1)

        return Array(page.movies.prefix(10))
    }
}
