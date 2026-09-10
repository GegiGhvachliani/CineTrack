//
//  MovieRelatedNewsSectionView.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct MovieRelatedNewsSectionView: View {

    // MARK: - Properties

    let news: [News]
    let onNewsTap: (News) -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        if !news.isEmpty {
            PagingHorizontalScrollView(
                headerText: MovieDetailsStrings.Content.relatedNews,
                seeAllTitle: MovieDetailsStrings.Content.seeAll,
                items: news,
                cellWidth: 307.5,
                cellHeight: 205,
                showsSeeAllButton: true,
                onSeeAllTap: onSeeAllTap
            ) { article, _ in
                NewsCell(news: article, cellHeight: 205) {
                    onNewsTap(article)
                }
            }
        }
    }
}
