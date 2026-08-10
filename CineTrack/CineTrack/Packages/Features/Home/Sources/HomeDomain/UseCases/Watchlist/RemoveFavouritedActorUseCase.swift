//
//  RemoveFavouritedActorUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

public protocol RemoveFavouritedActorUseCaseProtocol: Sendable {

    func execute(
        actorID: Int
    ) async throws
}

public final class RemoveFavouritedActorUseCase:
    RemoveFavouritedActorUseCaseProtocol,
    @unchecked Sendable
{
    private let repository: FavouriteRepositoryProtocol

    public init(
        repository: FavouriteRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        actorID: Int
    ) async throws {

        try await repository.removeFavouritedActor(
            id: actorID
        )
    }
}
