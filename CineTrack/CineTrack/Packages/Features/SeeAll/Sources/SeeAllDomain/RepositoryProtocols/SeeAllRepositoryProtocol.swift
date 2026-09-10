//
//  SeeAllRepositoryProtocol.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

@MainActor
public protocol SeeAllRepositoryProtocol {
    func fetchNextPage() async -> SeeAllPayload?
}
