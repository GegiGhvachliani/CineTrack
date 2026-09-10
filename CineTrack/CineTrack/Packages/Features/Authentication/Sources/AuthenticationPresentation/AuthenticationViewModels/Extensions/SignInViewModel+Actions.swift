import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation
import Observation

extension SignInViewModel {

    // MARK: - Actions

    public func navigateToSignUp() {
        onSignUp?()
    }
}
