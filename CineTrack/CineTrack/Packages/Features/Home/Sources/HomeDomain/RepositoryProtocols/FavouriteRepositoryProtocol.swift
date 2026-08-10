//
//  FavouriteRepositoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//


import Foundation

public protocol FavouriteRepositoryProtocol: Sendable {

    func fetchFavouritedActorIDs() async throws -> Set<Int>

    func addFavouritedActor(
        id: Int
    ) async throws

    func removeFavouritedActor(
        id: Int
    ) async throws
}