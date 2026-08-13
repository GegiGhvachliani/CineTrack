//
//  FetchNewsUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import SharedCore

public protocol FetchNewsUseCaseProtocol: Sendable {

    func execute(page: Int) async throws -> NewsPage
}

public final class FetchNewsUseCase: FetchNewsUseCaseProtocol {

    private let repository:HomeRepositoryProtocol

    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(page: Int) async throws -> NewsPage {

        try await repository.fetchNews(page: page)
    }
}
