//
//  FetchFanFavouritesUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import LibraryDomain

public protocol FetchFanFavouritesUseCaseProtocol: Sendable {

    func execute(page: Int) async throws -> MoviePage
}

public final class FetchFanFavouritesUseCase: FetchFanFavouritesUseCaseProtocol {

    // MARK: - Properties

    private let repository: HomeRepositoryProtocol

    // MARK: - Initialization

    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(page: Int) async throws -> MoviePage {

        try await repository.fetchFanFavourites(page: page)
    }
}
