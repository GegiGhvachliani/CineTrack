//
//  WatchlistRepositoryProtocol.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SharedCore

public protocol WatchlistRepositoryProtocol: Sendable {
    func fetchWatchlistedMovies() async throws -> [Movie]
    func addWatchlistedMovie(_ movie: Movie) async throws
    func removeWatchlistedMovie(_ movie: Movie) async throws
}
