//
//  ResetPasswordUseCase.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 04/07/2026.
//

public protocol ResetPasswordUseCaseProtocol: Sendable {
    func execute(email: String) async throws
}

public final class ResetPasswordUseCase: ResetPasswordUseCaseProtocol {

    // MARK: - Properties

    private let repository: AuthenticationRepositoryProtocol

    // MARK: - Initialization

    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(email: String) async throws {
        try await repository.resetPassword(email: email)
    }
}
