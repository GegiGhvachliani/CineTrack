//
//  FetchFavouritedActorIDsUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

public protocol FetchFavouritedActorIDsUseCaseProtocol: Sendable {

    func execute() async throws -> Set<Int>
}

public final class FetchFavouritedActorIDsUseCase:
    FetchFavouritedActorIDsUseCaseProtocol,
    @unchecked Sendable
{
    private let repository: FavouriteRepositoryProtocol

    public init(
        repository: FavouriteRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute() async throws -> Set<Int> {
        try await repository.fetchFavouritedActorIDs()
    }
}
