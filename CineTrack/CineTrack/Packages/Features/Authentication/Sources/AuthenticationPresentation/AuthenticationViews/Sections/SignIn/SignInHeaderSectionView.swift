import SwiftUI
import DesignSystemTokens

struct SignInHeaderSectionView: View {

    // MARK: - Body

    var body: some View {
        VStack(spacing: 10) {
            Text(AuthenticationStrings.SignIn.title)
                .font(TypographyTokens.largeTitle)
            Text(AuthenticationStrings.SignIn.subtitle)
                .font(TypographyTokens.body)
                .foregroundStyle(ColorTokens.Text.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 40)
    }
}
