//
//  AuthenticationRepositoryProtocol.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import Foundation

public protocol AuthenticationRepositoryProtocol: Sendable {
    func signInWithEmail(email: String, password: String) async throws -> User
    func signUpWithEmail(email: String, password: String) async throws -> User
    func signInWithGoogle() async throws -> User
}
