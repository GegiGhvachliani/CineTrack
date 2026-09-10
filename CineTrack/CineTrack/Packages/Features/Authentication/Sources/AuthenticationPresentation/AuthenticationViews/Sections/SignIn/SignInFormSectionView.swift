import SwiftUI
import DesignSystemTokens

struct SignInFormSectionView: View {

    // MARK: - Properties

    @Binding
    var email: String
    @Binding
    var password: String
    let onForgotPassword: () -> Void

    // MARK: - Body

    var body: some View {
        VStack {
            EmailFieldView(email: $email, text: AuthenticationStrings.SignIn.emailPlaceholder)
                .padding(.bottom, 20)

            PasswordFieldView(
                password: $password,
                title: AuthenticationStrings.SignIn.passwordPlaceholder
            )

            Button {
                onForgotPassword()
            } label: {
                Spacer()
                Text(AuthenticationStrings.ForgotPassword.navigationButtonText)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Brand.primary)
                    .offset(x: -7)
            }

        }
        .padding(.bottom, 40)
    }
}
