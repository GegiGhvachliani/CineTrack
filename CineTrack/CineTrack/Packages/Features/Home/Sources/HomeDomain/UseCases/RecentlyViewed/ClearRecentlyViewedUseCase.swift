//
//  ClearRecentlyViewedUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 12/08/2026.
//

import Foundation

public protocol ClearRecentlyViewedUseCaseProtocol:
Sendable {

    func execute() async throws
}

public final class ClearRecentlyViewedUseCase:
ClearRecentlyViewedUseCaseProtocol {

    private let repository:
        RecentlyViewedRepositoryProtocol

    public init(
        repository:
            RecentlyViewedRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute() async throws {

        try await repository
            .clearRecentlyViewed()
    }
}
