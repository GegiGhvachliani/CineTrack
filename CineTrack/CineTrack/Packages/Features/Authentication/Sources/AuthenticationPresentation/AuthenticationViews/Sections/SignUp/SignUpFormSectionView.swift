import SwiftUI
import DesignSystemTokens

struct SignUpFormSectionView: View {

    // MARK: - Properties

    @Binding
    var username: String
    @Binding
    var email: String
    @Binding
    var password: String
    @Binding
    var confirmPassword: String
    let onSignIn: () -> Void

    // MARK: - Body

    var body: some View {
        VStack {
            TextFieldView(
                title: AuthenticationStrings.SignUp.usernamePlaceholder,
                icon: "person.fill",
                text: $username
            )
            .padding(.bottom, 20)

            EmailFieldView(
                email: $email,
                text: AuthenticationStrings.SignUp.emailPlaceholder
            )
            .padding(.bottom, 20)

            PasswordFieldView(
                password: $password,
                title: AuthenticationStrings.SignUp.passwordPlaceholder
            )
            .padding(.bottom, 20)

            PasswordFieldView(
                password: $confirmPassword,
                title: AuthenticationStrings.SignUp.confirmPasswordPlaceholder
            )

            HStack {
                Spacer()

                Text(AuthenticationStrings.SignUp.alreadyHaveAccount)
                    .font(TypographyTokens.bodySmall)
                Button {
                    onSignIn()
                } label: {
                    Text(AuthenticationStrings.SignUp.signInLink)
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Brand.primary)
                        .offset(x: -7)
                }
                .frame(alignment: .trailing)
            }
        }
        .padding(.bottom, 40)
    }
}
