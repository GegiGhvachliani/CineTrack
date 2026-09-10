//
//  FeaturedItem.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import Foundation

public struct FeaturedItem: Identifiable, Equatable, Sendable {

    // MARK: - Properties

    public let id: Int
    public let movie: Movie
    public let video: MovieVideo

    // MARK: - Initialization

    public init(
        movie: Movie,
        video: MovieVideo
    ) {
        self.id = movie.id
        self.movie = movie
        self.video = video
    }
}
