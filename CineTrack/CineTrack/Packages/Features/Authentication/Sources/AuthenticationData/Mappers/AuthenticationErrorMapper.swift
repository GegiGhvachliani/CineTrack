import Foundation
import AuthenticationDomain

enum AuthenticationErrorMapper {

    static func map(_ error: Error) -> Error {
        if error is CancellationError {
            return error
        }

        let error = error as NSError

        guard error.domain == "FIRAuthErrorDomain" else {
            return AuthenticationError.serviceUnavailable
        }

        switch error.code {
        case 17011:
            return AuthenticationError.userNotFound
        case 17009, 17004:
            return AuthenticationError.wrongPassword
        case 17008:
            return AuthenticationError.invalidEmail
        case 17007:
            return AuthenticationError.emailAlreadyInUse
        case 17026:
            return AuthenticationError.weakPassword
        default:
            return AuthenticationError.serviceUnavailable
        }
    }
}
