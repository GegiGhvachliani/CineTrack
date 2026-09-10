//
//  News.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public struct News: Identifiable, Sendable, Equatable {

    // MARK: - Properties

    public let id: String
    public let imageURL: String?
    public let author: String?
    public let title: String
    public let description: String?
    public let articleURL: String
    public let publishedAt: Date

    // MARK: - Initialization

    public init(
        id: String,
        imageURL: String?,
        author: String?,
        title: String,
        description: String?,
        articleURL: String,
        publishedAt: Date
    ) {
        self.id = id
        self.imageURL = imageURL
        self.author = author
        self.title = title
        self.description = description
        self.articleURL = articleURL
        self.publishedAt = publishedAt
    }
}
