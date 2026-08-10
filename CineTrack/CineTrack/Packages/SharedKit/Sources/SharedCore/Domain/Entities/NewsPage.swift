//
//  NewsPage.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation

public struct NewsPage: Sendable, Equatable {

    public let news: [News]
    public let page: Int
    public let totalResults: Int

    public init(
        news: [News],
        page: Int,
        totalResults: Int
    ) {
        self.news = news
        self.page = page
        self.totalResults = totalResults
    }
}