//
//  FetchFavouritedActorsUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SharedCore

public protocol FetchFavouritedActorsUseCaseProtocol: Sendable {
    func execute() async throws -> [Actor]
}

public final class FetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol, @unchecked Sendable {
    private let repository: FavouriteActorRepositoryProtocol

    public init(repository: FavouriteActorRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> [Actor] {
        try await repository.fetchFavouritedActors()
    }
}
