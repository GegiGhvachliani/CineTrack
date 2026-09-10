//
//  FetchNewsDetailsUseCase.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

public protocol FetchNewsDetailsUseCaseProtocol: Sendable {
    func execute() -> News
}

public final class FetchNewsDetailsUseCase: FetchNewsDetailsUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: NewsDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: NewsDetailsRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute() -> News {
        repository.fetchArticle()
    }
}
