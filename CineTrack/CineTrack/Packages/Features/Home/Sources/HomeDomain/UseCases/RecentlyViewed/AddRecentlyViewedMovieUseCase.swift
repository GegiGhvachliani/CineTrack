//
//  AddRecentlyViewedMovieUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public protocol AddRecentlyViewedMovieUseCaseProtocol:
    Sendable {

    func execute(
        _ movie: RecentlyViewedMovie
    ) async throws
}

public final class AddRecentlyViewedMovieUseCase:
    AddRecentlyViewedMovieUseCaseProtocol {

    private let repository:
        RecentlyViewedRepositoryProtocol

    public init(
        repository:
            RecentlyViewedRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        _ movie: RecentlyViewedMovie
    ) async throws {

        try await repository
            .addRecentlyViewedMovie(movie)
    }
}
