//
//  ActorMediaPage.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorMediaPage: Sendable {

    // MARK: - Properties

    public let images: [ActorMediaImage]
    public let nextToken: String?

    // MARK: - Initialization

    public init(images: [ActorMediaImage], nextToken: String?) {
        self.images = images
        self.nextToken = nextToken
    }
}
