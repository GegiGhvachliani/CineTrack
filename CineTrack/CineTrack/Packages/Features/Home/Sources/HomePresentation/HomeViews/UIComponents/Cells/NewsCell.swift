//
//  NewsCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens
import SharedCore
import DesignSystemComponents

struct NewsCell: View {

    let news: News
    let cellHeight: CGFloat

    let onTap: () -> Void

    var body: some View {

        Button(action: onTap) {

            VStack(spacing: 0) {

                header

                Rectangle()
                    .fill(.secondary)
                    .frame(height: 1)

                footer
            }
            .frame(width: cellHeight * 1.5, height: cellHeight)
            .background(ColorTokens.Background.primary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
    }

    private var header: some View {

        HStack(spacing: 8) {

            PosterImageView(
                photoURL: news.imageURL
            )
            .frame(width: 75, height: 105)
            .clipShape(RoundedRectangle(cornerRadius: 5))

            VStack(alignment: .leading) {

                Text(news.author ?? "Unknown")
                .font(TypographyTokens.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(1)

                Text(news.title)
                    .font(TypographyTokens.bodySmallSmall)
                    .opacity(0.8)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 1)

                Spacer()

                Text(relativeDate(news.publishedAt))
                .font(TypographyTokens.footnote)
                .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .frame(height: cellHeight / 2)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }

    private var footer: some View {

        Text(news.description ?? "")
        .font(TypographyTokens.footnote)
        .foregroundStyle(.secondary)
        .lineLimit(4)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(8)
    }

    private func relativeDate(_ date: Date) -> String {

        let formatter = RelativeDateTimeFormatter()

        formatter.unitsStyle = .full

        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
