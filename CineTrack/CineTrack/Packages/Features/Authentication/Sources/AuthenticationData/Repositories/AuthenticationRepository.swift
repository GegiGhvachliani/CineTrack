//
//  AuthenticationRepository.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import AuthenticationDomain
import UIKit

public final class AuthenticationRepository: AuthenticationRepositoryProtocol {
    
    // MARK: - Initializations
    public init() {}
    
    // MARK: - Methods
    public func isUserAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    public func signInWithEmail(email: String, password: String) async throws -> AuthenticationDomain.User {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return User(
            id: authResult.user.uid,
            email: authResult.user.email ?? email,
            username: authResult.user.displayName ?? ""
        )
    }
    
    public func signUpWithEmail(email: String, username: String, password: String) async throws -> AuthenticationDomain.User {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        let changeRequest = authResult.user.createProfileChangeRequest()
        changeRequest.displayName = username
        
        try await changeRequest.commitChanges()
        
        return User(id: authResult.user.uid,
                    email: authResult.user.email ?? email,
                    username: username)
    }
    
    @MainActor
    public func signInWithGoogle() async throws -> AuthenticationDomain.User {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            throw NSError(
                domain: "AuthenticationData",
                code: -2,
                userInfo: [NSLocalizedDescriptionKey: "Unable to find root view controller for Google Sign-In presentation."]
            )
        }
        
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        let user = signInResult.user
        
        guard let idToken = user.idToken?.tokenString else {
            throw NSError(
                domain: "AuthenticationData",
                code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Google Sign-In failed to retrieve ID Token."]
            )
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
        
        let authResult = try await Auth.auth().signIn(with: credential)
        
        return AuthenticationDomain.User(
                id: authResult.user.uid,
                email: authResult.user.email ?? "",
                username: authResult.user.displayName ?? ""
            )
    }
    
    public func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
