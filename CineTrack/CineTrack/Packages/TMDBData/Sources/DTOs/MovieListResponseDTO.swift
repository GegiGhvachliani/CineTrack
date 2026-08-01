//
//  MovieListResponseDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public struct MovieListResponseDTO: Decodable {

    public let page: Int
    public let results: [MovieDTO]
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
