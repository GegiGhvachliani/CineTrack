//
//  FetchActorCreditsUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public protocol FetchActorCreditsUseCaseProtocol: Sendable {

    func execute(
        actorID: Int
    ) async throws -> [ActorCredit]
}

public struct FetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol {

    // MARK: - Properties

    private let repository: ActorDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(
        repository: ActorDetailsRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        actorID: Int
    ) async throws -> [ActorCredit] {
        try await repository.fetchActorCredits(
            actorID: actorID
        )
    }
}
