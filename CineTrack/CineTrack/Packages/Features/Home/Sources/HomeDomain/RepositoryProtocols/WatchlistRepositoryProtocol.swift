//
//  WatchlistRepositoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//


import Foundation

public protocol WatchlistRepositoryProtocol: Sendable {

    func fetchWatchlistedMovieIDs() async throws -> Set<Int>

    func addWatchlistedMovie(
        id: Int
    ) async throws

    func removeWatchlistedMovie(
        id: Int
    ) async throws
}