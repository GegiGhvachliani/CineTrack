//
//  NewsMapper.swift
//  NewsData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import SharedCore

public struct NewsMapper: Sendable {

    public init() {}

    public func map(
        _ dto: NewsArticleDTO
    ) -> News? {

        guard
            !dto.title.isEmpty,
            !dto.url.isEmpty,
            let publishedAt = parseDate(
                dto.publishedAt
            )
        else {
            return nil
        }

        return News(
            id: dto.url,
            imageURL: dto.urlToImage,
            author: dto.author ?? dto.source.name,
            title: dto.title,
            description: dto.description,
            articleURL: dto.url,
            publishedAt: publishedAt
        )
    }

    private func parseDate(
        _ value: String
    ) -> Date? {

        ISO8601DateFormatter().date(
            from: value
        )
    }
}
