//
//  SignInWithGoogleUseCase.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

public protocol SignInWithGoogleUseCaseProtocol: Sendable {
    func execute() async throws -> User
}

public final class SignInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol {

    // MARK: - Properties

    private let repository: AuthenticationRepositoryProtocol

    // MARK: - Initialization

    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> User {
        return try await repository.signInWithGoogle()
    }
}
