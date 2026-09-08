import SwiftUI
import SharedCore
import DesignSystemComponents

struct NewsSectionView: View {
    let news: [News]
    let onSeeAllTap: () -> Void
    let onNewsTap: (News) -> Void

    var body: some View {
        PagingHorizontalScrollView(
            headerText: HomeStrings.Section.news,
            seeAllTitle: HomeStrings.Action.seeAll,
            items: news,
            cellWidth: 330,
            cellHeight: 220,
            onSeeAllTap: onSeeAllTap
        ) { news, _ in
            NewsCell(
                news: news,
                cellHeight: 220,
                onTap: { onNewsTap(news) }
            )
        }
    }
}
