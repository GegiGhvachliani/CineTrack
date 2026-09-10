import SwiftUI
import DesignSystemTokens

struct SignUpActionsSectionView: View {

    // MARK: - Properties

    let isLoading: Bool
    let onSignUp: () -> Void

    // MARK: - Body

    var body: some View {
        ButtonView(
            title: AuthenticationStrings.SignUp.signUpButton,
            isLoading: isLoading
        ) {
            onSignUp()
        }
    }
}
