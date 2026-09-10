import SwiftUI
import DesignSystemTokens

struct SignUpHeaderSectionView: View {

    // MARK: - Body

    var body: some View {
        VStack(spacing: 10) {
            Text(AuthenticationStrings.SignUp.title)
                .font(TypographyTokens.largeTitle)
            Text(AuthenticationStrings.SignUp.subtitle)
                .font(TypographyTokens.body)
                .foregroundStyle(ColorTokens.Text.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 40)
    }
}
