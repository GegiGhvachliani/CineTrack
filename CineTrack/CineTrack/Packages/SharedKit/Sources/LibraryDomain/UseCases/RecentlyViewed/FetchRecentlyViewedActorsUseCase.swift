//
//  FetchRecentlyViewedActorsUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public protocol FetchRecentlyViewedActorsUseCaseProtocol: Sendable {

    func execute() async throws -> [RecentlyViewedActor]
}

public final class FetchRecentlyViewedActorsUseCase: FetchRecentlyViewedActorsUseCaseProtocol {

    // MARK: - Properties

    private let repository: RecentlyViewedRepositoryProtocol

    // MARK: - Initialization

    public init(repository: RecentlyViewedRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> [RecentlyViewedActor] {

        try await repository.fetchRecentlyViewedActors()
    }
}
