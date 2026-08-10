//
//  AddRecentlyViewedActorUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public protocol AddRecentlyViewedActorUseCaseProtocol:
    Sendable {

    func execute(
        _ actor: RecentlyViewedActor
    ) async throws
}

public final class AddRecentlyViewedActorUseCase:
    AddRecentlyViewedActorUseCaseProtocol {

    private let repository:
        RecentlyViewedRepositoryProtocol

    public init(
        repository:
            RecentlyViewedRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        _ actor: RecentlyViewedActor
    ) async throws {

        try await repository
            .addRecentlyViewedActor(actor)
    }
}
