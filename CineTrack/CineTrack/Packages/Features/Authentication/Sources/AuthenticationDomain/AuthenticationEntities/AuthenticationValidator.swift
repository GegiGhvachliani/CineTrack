//
//  AuthenticationValidator.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import Foundation

public protocol AuthenticationValidating: Sendable {
    func validateEmail(_ email: String) -> Bool
    func validatePasswordStrength(_ password: String) -> Bool
}

public final class AuthenticationValidator: AuthenticationValidating {
    
    public init() {}
    
    public func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    public func validatePasswordStrength(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9]).{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}
