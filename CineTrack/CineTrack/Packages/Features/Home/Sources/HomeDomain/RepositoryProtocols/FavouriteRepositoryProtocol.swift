//
//  FavouriteRepositoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation
import SharedCore

public protocol FavouriteRepositoryProtocol: Sendable {

    func fetchFavouritedActors() async throws -> [Actor]

    func addFavouritedActor(actor: Actor) async throws

    func removeFavouritedActor(actor: Actor) async throws
}
