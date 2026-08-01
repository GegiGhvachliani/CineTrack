//
//  MovieMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedCore

public struct MovieMapper {

    public init() {}

    public func map(_ dto: MovieDTO) -> Movie {
        Movie(
            id: dto.id,
            title: dto.title,
            overview: dto.overview ?? "",
            posterPath: dto.posterPath,
            backdropPath: dto.backdropPath,
            releaseDate: dto.releaseDate,
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount
        )
    }

    public func map(_ response: MovieListResponseDTO) -> [Movie] {
        response.results.map(map)
    }
}
