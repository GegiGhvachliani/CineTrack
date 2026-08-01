//
//  FetchNowPlayingUseCase.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public protocol FetchNowPlayingUseCaseProtocol: Sendable {
    func execute(page: Int) async throws -> MoviePage
}

public final class FetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol {
    
    private let repository: HomeRepositoryProtocol
    
    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(page: Int) async throws -> MoviePage {
        try await repository.fetchNowPlaying(page: page)
    }
}
