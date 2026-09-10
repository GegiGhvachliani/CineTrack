//
//  NewsDetailsViewModel.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import Observation

import NewsDetailsDomain
import SharedCore

@Observable
@MainActor
public final class NewsDetailsViewModel: NewsDetailsViewModelProtocol {

    // MARK: - Content

    public let news: News

    public var sourceName: String {
        news.author ?? NewsDetailsStrings.Article.source
    }

    public var articleURL: URL? {
        guard let url = URL(string: news.articleURL),
            ["https", "http"].contains(url.scheme?.lowercased() ?? "")
        else {
            return nil
        }

        return url
    }

    public var metadata: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: news.publishedAt, relativeTo: .now)

        return NewsDetailsStrings.Article.metadata(date: relativeDate, source: sourceName)
    }

    // MARK: - Actions

    public var onOpenSource: ((URL) -> Void)?

    // MARK: - Initialization

    public init(fetchNewsDetailsUseCase: FetchNewsDetailsUseCaseProtocol) {
        self.news = fetchNewsDetailsUseCase.execute()
    }

}
