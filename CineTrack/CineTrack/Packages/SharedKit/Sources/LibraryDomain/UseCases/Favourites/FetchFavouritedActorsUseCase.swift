//
//  FetchFavouritedActorsUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation
import SharedCore

public protocol FetchFavouritedActorsUseCaseProtocol: Sendable {

    func execute() async throws -> [Actor]
}

public final class FetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: FavouriteRepositoryProtocol

    // MARK: - Initialization

    public init(repository: FavouriteRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> [Actor] {

        try await repository.fetchFavouritedActors()
    }
}
