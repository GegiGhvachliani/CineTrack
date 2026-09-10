import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct MovieDetailsErrorSectionView: View {

    // MARK: - Properties

    let errorMessage: String?
    let onRetry: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            ContentUnavailableView(
                MovieDetailsStrings.Content.unableToLoadMovie,
                systemImage: "exclamationmark.triangle",
                description: Text(errorMessage ?? MovieDetailsStrings.Content.pleaseTryAgain)
            )

            Button(MovieDetailsStrings.Content.tryAgain) {
                onRetry()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
