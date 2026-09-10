import SwiftUI
import SharedCore
import DesignSystemComponents
import DesignSystemTokens

struct NewsSectionView: View {

    // MARK: - Properties

    let news: [News]
    let isLoading: Bool
    let error: Error?
    let onSeeAllTap: () -> Void
    let onNewsTap: (News) -> Void
    let onRetryTap: () -> Void

    // MARK: - Body

    var body: some View {
        if !news.isEmpty {
            PagingHorizontalScrollView(
                headerText: HomeStrings.Section.news, seeAllTitle: HomeStrings.Action.seeAll, items: news,
                cellWidth: 330, cellHeight: 220, onSeeAllTap: onSeeAllTap
            ) { article, _ in
                NewsCell(news: article, cellHeight: 220, onTap: { onNewsTap(article) })
            }
        } else if isLoading {
            statusView(message: HomeStrings.Content.refreshingNews, actionTitle: nil, action: nil, loading: true)
        } else if error != nil {
            statusView(
                message: HomeStrings.Content.newsIsTemporarilyUnavailable, actionTitle: HomeStrings.Content.tryAgain,
                action: onRetryTap, loading: false)
        }
    }

    private func statusView(message: String, actionTitle: String?, action: (() -> Void)?, loading: Bool) -> some View {
        VStack(spacing: SpacingTokens.small) {
            if loading { ProgressView() }
            Text(message).font(TypographyTokens.bodySmall).foregroundStyle(loading ? .secondary : ColorTokens.Text.main)
            if let actionTitle, let action {
                Button(actionTitle, action: action).font(TypographyTokens.bodySmall).foregroundStyle(
                    ColorTokens.Button.textButton
                ).buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, SpacingTokens.xLarge)
        .background(ColorTokens.Background.secondary)
    }
}
