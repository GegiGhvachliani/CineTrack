//
//  PopularPeopleResponseDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public struct PopularPeopleResponseDTO: Decodable, Sendable {

    // MARK: - Properties

    public let page: Int
    public let results: [PersonDTO]
    public let totalPages: Int
    public let totalResults: Int

    // MARK: - Initialization

    public init(
        page: Int,
        results: [PersonDTO],
        totalPages: Int,
        totalResults: Int
    ) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
