import SwiftUI
import DesignSystemTokens

struct SignInActionsSectionView: View {

    // MARK: - Properties

    let isLoading: Bool
    let isEmailLoading: Bool
    let isGoogleLoading: Bool
    let onEmailSignIn: () -> Void
    let onGoogleSignIn: () -> Void
    let onSignUp: () -> Void

    // MARK: - Body

    var body: some View {
        VStack {
            ButtonView(
                title: AuthenticationStrings.SignIn.signInButton,
                isLoading: isEmailLoading
            ) {
                onEmailSignIn()
            }

            HStack(spacing: 15) {
                Rectangle()
                    .fill(DesignSystemTokens.ColorTokens.Brand.primary.opacity(0.5))
                    .frame(width: 150, height: 1)
                Text(AuthenticationStrings.Content.alternative)
                    .font(DesignSystemTokens.TypographyTokens.footnote)
                Rectangle()
                    .fill(DesignSystemTokens.ColorTokens.Brand.primary.opacity(0.8))
                    .frame(width: 150, height: 1)
            }

            Button {
                onGoogleSignIn()
            } label: {
                HStack {
                    if isGoogleLoading {
                        ProgressView()
                            .progressViewStyle(
                                CircularProgressViewStyle(tint: DesignSystemTokens.ColorTokens.Text.onBrand)
                            )
                    } else {
                        Text(AuthenticationStrings.SignIn.googleButton)
                            .font(TypographyTokens.body)
                            .foregroundStyle(DesignSystemTokens.ColorTokens.Text.onBrand)
                        Image(AuthenticationStrings.SignIn.googleButtonIcon, bundle: .module)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 5)
                    }
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(DesignSystemTokens.ColorTokens.Brand.primary)
                .cornerRadius(15)
            }
            .disabled(isLoading)

            HStack {

                Text(AuthenticationStrings.SignIn.dontHaveAccount)
                    .font(TypographyTokens.bodySmall)
                Button {
                    onSignUp()
                } label: {
                    Text(AuthenticationStrings.SignIn.signUpLink)
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Brand.primary)
                        .offset(x: -7)
                }
            }
        }
    }
}
