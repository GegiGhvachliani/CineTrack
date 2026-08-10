//
//  AddFavouritedActorUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

public protocol AddFavouritedActorUseCaseProtocol: Sendable {

    func execute(
        actorID: Int
    ) async throws
}

public final class AddFavouritedActorUseCase:
    AddFavouritedActorUseCaseProtocol,
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

        try await repository.addFavouritedActor(
            id: actorID
        )
    }
}
