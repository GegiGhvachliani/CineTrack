//
//  NewsResponseDTO.swift
//  NewsData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public struct NewsResponseDTO: Decodable, Sendable {

    public let status: String
    public let totalResults: Int
    public let articles: [NewsArticleDTO]

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
