//
//  WatchlistRepositoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

import SharedCore

public protocol WatchlistRepositoryProtocol: Sendable {

    func fetchWatchlistedMovies() async throws -> [Movie]

    func addWatchlistedMovie(
        movie: Movie
    ) async throws

    func removeWatchlistedMovie(
        movie: Movie
    ) async throws
}
