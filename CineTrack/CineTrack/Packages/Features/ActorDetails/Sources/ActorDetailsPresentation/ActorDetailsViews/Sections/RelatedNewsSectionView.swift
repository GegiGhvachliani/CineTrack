//
//  RemoveWatchlistedMovieUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import DesignSystemComponents

struct RelatedNewsSectionView: View {

    // MARK: - Properties

    let news: [News]
    let onNewsTap: (News) -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        if !news.isEmpty {
            PagingHorizontalScrollView(
                headerText: ActorDetailsStrings.Content.relatedNews,
                seeAllTitle: ActorDetailsStrings.Content.seeAll,
                items: news,
                cellWidth: 307.5,
                cellHeight: 205,
                showsSeeAllButton: true,
                onSeeAllTap: onSeeAllTap
            ) { article, _ in
                NewsCell(
                    news: article,
                    cellHeight: 205,
                    onTap: { onNewsTap(article) }
                )
            }
        }
    }
}
