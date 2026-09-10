//
//  ActorMediaRepositoryProtocol.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public protocol ActorMediaRepositoryProtocol: Sendable {
    func fetchImages(actorName: String, continuation: String?) async throws -> ActorMediaPage
}
