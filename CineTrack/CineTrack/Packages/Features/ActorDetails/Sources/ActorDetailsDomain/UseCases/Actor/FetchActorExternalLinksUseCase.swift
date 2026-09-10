//
//  FetchActorExternalLinksUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public protocol FetchActorExternalLinksUseCaseProtocol: Sendable {

    func execute(
        actorID: Int
    ) async throws -> ActorExternalLinks
}

public struct FetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol {

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
    ) async throws -> ActorExternalLinks {
        try await repository.fetchActorExternalLinks(
            actorID: actorID
        )
    }
}
