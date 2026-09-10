//
//  KeywordListResponseDTO.swift
//  TMDBData
//

import Foundation

public struct KeywordListResponseDTO: Decodable, Sendable {

    // MARK: - Properties

    public let page: Int
    public let results: [KeywordDTO]
    public let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
