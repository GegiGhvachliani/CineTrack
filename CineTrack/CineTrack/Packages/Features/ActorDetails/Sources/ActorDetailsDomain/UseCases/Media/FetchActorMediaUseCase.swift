//
//  FetchActorDetailsUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public protocol FetchActorMediaUseCaseProtocol: Sendable {
    func execute(actorName: String, continuation: String?) async throws -> ActorMediaPage
}

public final class FetchActorMediaUseCase: FetchActorMediaUseCaseProtocol {

    // MARK: - Properties

    private let repository: ActorMediaRepositoryProtocol

    // MARK: - Initialization

    public init(repository: ActorMediaRepositoryProtocol) { self.repository = repository }
    public func execute(actorName: String, continuation: String?) async throws -> ActorMediaPage {
        try await repository.fetchImages(actorName: actorName, continuation: continuation)
    }
}
