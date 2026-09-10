//
//  HomeRepository+News.swift
//  Home
//
//  Created by Gegi Ghvachliani on 12/08/2026.
//

import Foundation
import HomeDomain
import SharedNetworking
import NewsData
import SharedCore

extension HomeRepository {

    // MARK: - News

    public func fetchNews(page: Int) async throws -> NewsPage {

        let request = try newsRequestBuilder.build(for: .entertainment(page: page, pageSize: 20))

        let response: NewsResponseDTO = try await apiClient.sendRequest(request)

        let news = response.articles.compactMap {
            newsMapper.map($0)
        }

        return NewsPage(news: news, page: page, totalResults: response.totalResults)
    }
}
