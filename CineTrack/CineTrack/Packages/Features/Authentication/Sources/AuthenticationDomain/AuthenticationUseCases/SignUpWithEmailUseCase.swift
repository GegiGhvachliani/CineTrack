//
//  SignUpWithEmailUseCase.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//


public protocol SignUpWithEmailUseCaseProtocol: Sendable {
    func execute(email: String, password: String) async throws -> User
}

public final class SignUpWithEmailUseCase: SignInWithGoogleUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol
    
    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(email: String, password: String) async throws -> User {
        return try await repository.signUpWithEmail(email: email, password: password)
    }
}
