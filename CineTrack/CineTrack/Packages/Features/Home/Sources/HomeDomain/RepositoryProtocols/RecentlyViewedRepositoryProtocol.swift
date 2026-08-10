//
//  RecentlyViewedRepositoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation

public protocol RecentlyViewedRepositoryProtocol: Sendable {

    func fetchRecentlyViewedMovies() async throws
        -> [RecentlyViewedMovie]

    func addRecentlyViewedMovie(
        _ movie: RecentlyViewedMovie
    ) async throws

    func fetchRecentlyViewedActors() async throws
        -> [RecentlyViewedActor]

    func addRecentlyViewedActor(
        _ actor: RecentlyViewedActor
    ) async throws
}