//
//  FetchFanFavouritesUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import HomeDomain

public protocol FetchFanFavouritesUseCaseProtocol: Sendable {

    func execute(
        page: Int
    ) async throws -> MoviePage
}

public final class FetchFanFavouritesUseCase:
    FetchFanFavouritesUseCaseProtocol {

    private let repository: HomeRepositoryProtocol

    public init(
        repository: HomeRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        page: Int
    ) async throws -> MoviePage {

        try await repository.fetchFanFavourites(
            page: page
        )
    }
}
