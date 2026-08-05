//
//  MovieMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedCore

// მისი პასუხისმგებლობაა : External Data Model → Domain Model
/*
 MovieDTO       MovieListResponseDTO
     ↓                   ↓
 Movie                [Movie]
 */

/*
 ვთქვათ MovieDTO არის:
 
 MovieDTO(
     id: 123,
     title: "Inception",
     overview: nil,
     posterPath: "/abc.jpg",
     ...
 )

 მაგრამ შენი Domain Model შეიძლება იყოს:

 Movie(
     title: "Inception",
     overview: "",
     posterPath: "https://image.tmdb.org/t/p/w500/abc.jpg",
     ...
 )

 აქ უკვე ხდება data transformation.

 მაგალითად:

 DTO:
 overview = nil

         ↓ Mapper

 Domain:
 overview = ""
 */
public struct MovieMapper: Sendable {

    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    public init() {}

    // MovieDTO-დან Domain Movie-დ გარდაქმნა
    public func map(_ dto: MovieDTO) -> Movie {
        Movie(
            id: dto.id,
            title: dto.title,
            overview: dto.overview ?? "",
            posterPath: makeImageURL(from: dto.posterPath),
            backdropPath: makeImageURL(from: dto.backdropPath),
            releaseDate: dto.releaseDate,
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount
        )
    }
    
    // [MovieDTO, MovieDTO, MovieDTO] -> ზედა ფუნქციის გამოყენებით -> [Movie, Movie, Movie]
    public func map(_ response: MovieListResponseDTO) -> [Movie] {
        response.results.map(map)
    }

    private func makeImageURL(from path: String?) -> String? {
        guard let path, !path.isEmpty else {
            return nil
        }

        if path.hasPrefix("http") {
            return path
        }

        return "\(imageBaseURL)\(path)"
    }
}
