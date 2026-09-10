//
//  MovieImage.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation

public struct MovieImage: Identifiable, Equatable, Sendable {

    // MARK: - Properties

    public let id: String
    public let url: URL
    public let aspectRatio: Double

    // MARK: - Initialization

    public init(id: String, url: URL, aspectRatio: Double) {
        self.id = id
        self.url = url
        self.aspectRatio = aspectRatio
    }
}
