import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct NewsDetailsHeaderSectionView: View {

    // MARK: - Properties

    let title: String
    let metadata: String

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: SpacingTokens.small) {
            Text(metadata)
                .font(TypographyTokens.footnote)
                .foregroundStyle(.secondary)

            Text(title)
                .font(TypographyTokens.title2)
                .foregroundStyle(ColorTokens.Brand.primary)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, SpacingTokens.regular)
    }
}
