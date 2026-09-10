import AuthenticationDomain

extension AuthenticationError {

    // MARK: - Properties

    var message: String {
        switch self {
        case .emptyFields:
            AuthenticationStrings.Errors.emptyFields
        case .invalidEmail:
            AuthenticationStrings.Errors.invalidEmail
        case .weakPassword:
            AuthenticationStrings.Errors.shortPassword
        case .passwordMismatch:
            AuthenticationStrings.Errors.passwordMismatch
        case .userNotFound:
            AuthenticationStrings.Errors.userNotFound
        case .wrongPassword:
            AuthenticationStrings.Errors.wrongPassword
        case .emailAlreadyInUse:
            AuthenticationStrings.Errors.emailAlreadyInUse
        case .serviceUnavailable:
            AuthenticationStrings.Errors.serviceUnavailable
        }
    }
}
