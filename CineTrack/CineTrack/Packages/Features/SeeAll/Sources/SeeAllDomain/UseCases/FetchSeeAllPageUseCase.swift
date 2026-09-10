//
//  FetchSeeAllPageUseCase.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

@MainActor
public protocol FetchSeeAllPageUseCaseProtocol {
    func execute() async -> SeeAllPayload?
}

public final class FetchSeeAllPageUseCase: FetchSeeAllPageUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: SeeAllRepositoryProtocol

    // MARK: - Initialization

    public init(repository: SeeAllRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute() async -> SeeAllPayload? {
        await repository.fetchNextPage()
    }
}
