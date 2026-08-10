//
//  RecentlyViewedMovieDTO.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

import HomeDomain

struct RecentlyViewedMovieDTO:
    Codable,
    Sendable {

    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let viewedAt: Date

    init(
        movie: RecentlyViewedMovie
    ) {
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.viewedAt = movie.viewedAt
    }

    func toDomain()
        -> RecentlyViewedMovie {

        RecentlyViewedMovie(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            viewedAt: viewedAt
        )
    }
}
