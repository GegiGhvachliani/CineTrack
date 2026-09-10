//
//  ActorPage.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public struct ActorPage: Sendable, Equatable {

    // MARK: - Properties

    public let actors: [Actor]
    public let page: Int
    public let hasNextPage: Bool

    // MARK: - Initialization

    public init(
        actors: [Actor],
        page: Int,
        hasNextPage: Bool
    ) {
        self.actors = actors
        self.page = page
        self.hasNextPage = hasNextPage
    }
}
