//
//  FetchActorDetailsUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public protocol FetchActorDetailsUseCaseProtocol: Sendable {

    func execute(
        actorID: Int
    ) async throws -> ActorDetails
}

public struct FetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol {

    private let repository: ActorDetailsRepositoryProtocol

    public init(
        repository: ActorDetailsRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        actorID: Int
    ) async throws -> ActorDetails {
        try await repository.fetchActorDetails(
            actorID: actorID
        )
    }
}
