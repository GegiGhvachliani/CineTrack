//
//  FetchUpcomingUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public protocol FetchUpcomingUseCaseProtocol: Sendable {
    func execute(page: Int) async throws -> MoviePage
}

public final class FetchUpcomingUseCase: FetchUpcomingUseCaseProtocol {

    // MARK: - Properties

    private let repository: HomeRepositoryProtocol

    // MARK: - Initialization

    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(page: Int) async throws -> MoviePage {
        try await repository.fetchUpcoming(page: page)
    }
}
