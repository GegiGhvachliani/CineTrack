//
//  FetchRecentlyViewedMoviesUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public protocol FetchRecentlyViewedMoviesUseCaseProtocol:
    Sendable {

    func execute() async throws
        -> [RecentlyViewedMovie]
}

public final class FetchRecentlyViewedMoviesUseCase:
    FetchRecentlyViewedMoviesUseCaseProtocol {

    private let repository:
        RecentlyViewedRepositoryProtocol

    public init(
        repository:
            RecentlyViewedRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute() async throws
        -> [RecentlyViewedMovie] {

        try await repository
            .fetchRecentlyViewedMovies()
    }
}
