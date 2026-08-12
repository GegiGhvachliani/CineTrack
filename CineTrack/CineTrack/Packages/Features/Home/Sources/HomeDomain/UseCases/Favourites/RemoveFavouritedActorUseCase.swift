//
//  RemoveFavouritedActorUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation
import SharedCore


public protocol RemoveFavouritedActorUseCaseProtocol: Sendable {

    func execute(
        actor: Actor
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
    actor: Actor
) async throws {

    try await repository.removeFavouritedActor(
        actor: actor
    )
}
}
