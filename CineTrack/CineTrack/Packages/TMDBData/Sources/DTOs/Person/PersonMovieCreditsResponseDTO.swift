//
//  PersonMovieCreditsResponseDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/09/2026.
//

import Foundation

public struct PersonMovieCreditsResponseDTO: Decodable {
    public let cast: [MovieDTO]
}
