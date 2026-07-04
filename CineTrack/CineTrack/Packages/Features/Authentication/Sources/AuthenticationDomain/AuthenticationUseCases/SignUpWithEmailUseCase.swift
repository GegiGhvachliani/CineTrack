//
//  SignUpWithEmailUseCase.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//


public protocol SignUpWithEmailUseCaseProtocol: Sendable {
    func execute(email: String, username: String, password: String) async throws -> User
}

public final class SignUpWithEmailUseCase: SignUpWithEmailUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol
    
    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(email: String, username: String, password: String) async throws -> User {
        try await repository.signUpWithEmail(email: email,username: username, password: password)
    }
}
