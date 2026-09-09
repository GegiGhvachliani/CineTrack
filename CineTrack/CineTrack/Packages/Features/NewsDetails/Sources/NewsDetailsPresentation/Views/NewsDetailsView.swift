//
//  NewsDetailsView.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

public struct NewsDetailsView: View {

    // MARK: - Properties

    private let news: News

    // MARK: - Initialization

    public init(news: News) {
        self.news = news
    }

    // MARK: - Body

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SpacingTokens.large) {
                header
                articleImage
                articleDescription
                sourceLink
            }
            .padding(.vertical, SpacingTokens.regular)
        }
        .scrollIndicators(.hidden)
        .background(ColorTokens.Background.secondary)
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: SpacingTokens.small) {
            Text(metadata)
                .font(TypographyTokens.footnote)
                .foregroundStyle(.secondary)

            Text(news.title)
                .font(TypographyTokens.title2)
                .foregroundStyle(ColorTokens.Brand.primary)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, SpacingTokens.regular)
    }

    // MARK: - Image

    private var articleImage: some View {
        PosterImageView(photoURL: news.imageURL)
            .frame(maxWidth: .infinity)
            .frame(height: 225)
    }

    // MARK: - Description

    private var articleDescription: some View {
        Text(news.description ?? "No description is available for this article.")
            .font(TypographyTokens.bodySmall)
            .foregroundStyle(ColorTokens.Text.main)
            .padding(.horizontal, SpacingTokens.regular)
    }

    // MARK: - Source link

    @ViewBuilder
    private var sourceLink: some View {
        if let articleURL = URL(string: news.articleURL) {
            Divider()
                .padding(.horizontal, SpacingTokens.regular)

            Link(destination: articleURL) {
                HStack(spacing: SpacingTokens.small) {
                    Text("See full article on \(sourceName)")
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                }
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(ColorTokens.Brand.primary)
                .padding(.horizontal, SpacingTokens.regular)
                .frame(height: 44)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(ColorTokens.Brand.primary, lineWidth: 1)
                }
            }
            .padding(.horizontal, SpacingTokens.regular)
        }
    }

    // MARK: - Helpers

    private var metadata: String {
        "\(relativeDate) · \(sourceName)"
    }

    private var sourceName: String {
        news.author ?? "the source"
    }

    private var relativeDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: news.publishedAt, relativeTo: .now)
    }
}

#Preview {
    NavigationStack {
        NewsDetailsView(
            news: News(
                id: "preview",
                imageURL: nil,
                author: "TV Insider",
                title: "Family Drama Runs Deep in 'East of Eden'",
                description: "Read the latest entertainment news and open the original source for the complete article.",
                articleURL: "https://www.tvinsider.com",
                publishedAt: .now.addingTimeInterval(-64_800)
            )
        )
    }
}
