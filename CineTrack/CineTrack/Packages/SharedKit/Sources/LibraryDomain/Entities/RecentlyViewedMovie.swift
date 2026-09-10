//
//  RecentlyViewedMovie.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import SharedCore

public struct RecentlyViewedMovie: Identifiable, Sendable, Equatable {

    // MARK: - Properties

    public let id: Int
    public let title: String
    public let posterPath: String?
    public let releaseDate: String?
    public let voteAverage: Double
    public let viewedAt: Date

    // MARK: - Initialization

    public init(
        id: Int,
        title: String,
        posterPath: String?,
        releaseDate: String?,
        voteAverage: Double,
        viewedAt: Date
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.viewedAt = viewedAt
    }
}
