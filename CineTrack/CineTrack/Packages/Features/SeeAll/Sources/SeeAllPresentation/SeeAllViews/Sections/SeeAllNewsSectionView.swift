//
//  SeeAllNewsSectionView.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct SeeAllNewsSectionView: View {

    // MARK: - Properties

    let news: [News]
    let onTap: (News) -> Void
    let onLoadMore: (Int, Int) -> Void

    // MARK: - Body

    var body: some View {
        List(news) { article in
            Button {
                onTap(article)
            } label: {
                CompactNewsCell(news: article)
            }
            .buttonStyle(.plain)
            .onAppear {
                loadMoreIfNeeded(index: news.firstIndex(where: { $0.id == article.id }) ?? 0, count: news.count)
            }
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            .listRowBackground(ColorTokens.Background.secondary)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ColorTokens.Background.secondary)
        .overlay { SeeAllEmptyStateView(isEmpty: news.isEmpty) }
    }

    // MARK: - Pagination

    private func loadMoreIfNeeded(index: Int, count: Int) {
        onLoadMore(index, count)
    }
}
