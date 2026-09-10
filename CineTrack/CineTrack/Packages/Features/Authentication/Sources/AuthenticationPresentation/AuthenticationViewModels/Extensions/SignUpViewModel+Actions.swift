import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation
import Observation

extension SignUpViewModel {

    // MARK: - Actions

    public func navigateToSignIn() {
        onSignIn?()
    }
}
