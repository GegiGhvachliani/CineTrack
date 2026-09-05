//
//  FetchActorImagesUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public protocol FetchActorImagesUseCaseProtocol: Sendable {

    func execute(
        actorID: Int
    ) async throws -> [ActorImage]
}

public struct FetchActorImagesUseCase: FetchActorImagesUseCaseProtocol {

    private let repository: ActorDetailsRepositoryProtocol

    public init(
        repository: ActorDetailsRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(
        actorID: Int
    ) async throws -> [ActorImage] {
        try await repository.fetchActorImages(
            actorID: actorID
        )
    }
}
