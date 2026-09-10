public enum AuthenticationError: Error, Sendable, Equatable {
    case emptyFields
    case invalidEmail
    case weakPassword
    case passwordMismatch
    case userNotFound
    case wrongPassword
    case emailAlreadyInUse
    case serviceUnavailable
}
