//
//  FetchActorNewsUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//


import Foundation
import SharedCore

public protocol FetchActorNewsUseCaseProtocol: Sendable {
    func execute(actorName: String) async throws -> [News]
}

public struct FetchActorNewsUseCase: FetchActorNewsUseCaseProtocol {
    private let repository: ActorDetailsRepositoryProtocol

    public init(repository: ActorDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(actorName: String) async throws -> [News] {
        try await repository.fetchActorNews(actorName: actorName)
    }
}
