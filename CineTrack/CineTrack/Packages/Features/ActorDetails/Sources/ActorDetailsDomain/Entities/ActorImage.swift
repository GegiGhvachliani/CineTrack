//
//  ActorImage.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorImage: Identifiable, Equatable, Sendable {

    // MARK: - Identity

    public let id: String

    // MARK: - Image

    public let filePath: String
    public let width: Int
    public let height: Int
    public let aspectRatio: Double

    // MARK: - Metadata

    public let voteAverage: Double
    public let voteCount: Int

    // MARK: - Init

    public init(
        id: String,
        filePath: String,
        width: Int,
        height: Int,
        aspectRatio: Double,
        voteAverage: Double,
        voteCount: Int
    ) {
        self.id = id
        self.filePath = filePath
        self.width = width
        self.height = height
        self.aspectRatio = aspectRatio
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
