//
//  ActorDetailsRepositoryProtocol.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public protocol ActorDetailsRepositoryProtocol: Sendable {

    func fetchActorDetails(
        actorID: Int
    ) async throws -> ActorDetails

    func fetchActorCredits(
        actorID: Int
    ) async throws -> [ActorCredit]

    func fetchActorImages(
        actorID: Int
    ) async throws -> [ActorImage]

    func fetchActorExternalLinks(
        actorID: Int
    ) async throws -> ActorExternalLinks
}
