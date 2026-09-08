//
//  FirestoreMovieDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//


import SharedCore

struct FirestoreMovieDTO: Codable, Sendable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int

    init(movie: Movie) {
        id = movie.id
        title = movie.title
        overview = movie.overview
        posterPath = movie.posterPath
        backdropPath = movie.backdropPath
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        voteCount = movie.voteCount
    }

    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
    }
}
