//
//  SignInWithEmailUseCase.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//


public protocol SignInWithEmailUseCaseProtocol: Sendable {
    func execute(email: String, password: String) async throws -> User
}

public final class SignInWithEmailUseCase: SignInWithEmailUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol
    
    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(email: String, password: String) async throws -> User {
        return try await repository.signInWithEmail(email: email, password: password)
    }
}
