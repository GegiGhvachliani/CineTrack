//
//  NewsArticleDTO.swift
//  NewsData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public struct NewsArticleDTO: Decodable, Sendable {

    // MARK: - Properties

    public let source: SourceDTO
    public let author: String?
    public let title: String
    public let description: String?
    public let url: String
    public let urlToImage: String?
    public let publishedAt: String
    public let content: String?

    public struct SourceDTO: Decodable, Sendable {

        public let id: String?
        public let name: String?
    }

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}
