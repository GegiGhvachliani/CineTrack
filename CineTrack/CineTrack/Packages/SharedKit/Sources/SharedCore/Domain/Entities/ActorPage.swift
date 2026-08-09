//
//  ActorPage.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation

public struct ActorPage: Sendable, Equatable {

    public let actors: [Actor]
    public let page: Int
    public let totalPages: Int

    public init(
        actors: [Actor],
        page: Int,
        totalPages: Int
    ) {
        self.actors = actors
        self.page = page
        self.totalPages = totalPages
    }

    public var hasNextPage: Bool {
        page < totalPages
    }
}