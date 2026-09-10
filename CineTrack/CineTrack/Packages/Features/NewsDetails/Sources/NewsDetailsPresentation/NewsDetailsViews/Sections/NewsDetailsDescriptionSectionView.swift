import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct NewsDetailsDescriptionSectionView: View {

    // MARK: - Properties

    let description: String?

    // MARK: - Body

    var body: some View {
        Text(description ?? NewsDetailsStrings.Article.noDescription)
            .font(TypographyTokens.bodySmall)
            .foregroundStyle(ColorTokens.Text.main)
            .padding(.horizontal, SpacingTokens.regular)
    }
}
