//
//  AddFavouritedActorUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation
import SharedCore

public protocol AddFavouritedActorUseCaseProtocol: Sendable {

    func execute(actor: Actor) async throws

}

public final class AddFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: FavouriteRepositoryProtocol

    // MARK: - Initialization

    public init(repository: FavouriteRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(actor: Actor) async throws {

        try await repository.addFavouritedActor(actor: actor)
    }
}
