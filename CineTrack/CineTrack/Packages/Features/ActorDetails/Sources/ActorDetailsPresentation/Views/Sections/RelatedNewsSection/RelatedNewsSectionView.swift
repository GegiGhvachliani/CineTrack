//
//  RemoveWatchlistedMovieUseCase.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import SharedCore
import DesignSystemComponents

struct RelatedNewsSectionView: View {
    let news: [News]
    let onNewsTap: (News) -> Void
    let onSeeAllTap: () -> Void

    var body: some View {
        if !news.isEmpty {
            PagingHorizontalScrollView(
                headerText: "Related News",
                seeAllTitle: "See All",
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
