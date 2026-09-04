//
//  NewsDetailsView.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import SharedCore

public struct NewsDetailsView: View {

    private let news: News

    public init(news: News) {
        self.news = news
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "newspaper")
                .font(.system(size: 72))
                .foregroundStyle(.secondary)

            Text(news.title)
                .font(.title.bold())

            Text("News Details")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
    }
}
