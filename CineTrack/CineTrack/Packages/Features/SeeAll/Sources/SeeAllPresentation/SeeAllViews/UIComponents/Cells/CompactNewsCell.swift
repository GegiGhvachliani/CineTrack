import SwiftUI
import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct CompactNewsCell: View {

    // MARK: - Properties

    let news: News

    // MARK: - Body

    var body: some View {
        HStack(spacing: SpacingTokens.medium) {
            NewsImageView(photoURL: news.imageURL, height: 54)
                .frame(width: 72)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: SpacingTokens.xSmall) {
                Text(news.title)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(2)

                Text(news.author ?? SeeAllStrings.Content.news)
                    .font(TypographyTokens.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}
