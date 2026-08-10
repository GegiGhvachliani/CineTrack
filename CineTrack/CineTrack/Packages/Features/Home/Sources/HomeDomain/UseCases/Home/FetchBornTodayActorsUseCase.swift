//
//  FetchBornTodayActorsUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import SharedCore

public protocol FetchBornTodayActorsUseCaseProtocol: Sendable {

    func execute(page: Int) async throws -> ActorPage
}

public final class FetchBornTodayActorsUseCase:
    FetchBornTodayActorsUseCaseProtocol {

    private let repository: HomeRepositoryProtocol

    public init(
        repository: HomeRepositoryProtocol
    ) {
        self.repository = repository
    }

    public func execute(page: Int) async throws -> ActorPage {
        try await repository.fetchBornTodayActors(page: page)
    }
}
