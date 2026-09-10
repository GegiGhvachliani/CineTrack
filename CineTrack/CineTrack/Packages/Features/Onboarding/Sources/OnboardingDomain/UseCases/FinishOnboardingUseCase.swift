//
//  FinishOnboardingUseCase.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 29/06/2026.
//

public protocol FinishOnboardingUseCaseProtocol {
    func execute()
}

public final class FinishOnboardingUseCase: FinishOnboardingUseCaseProtocol {

    // MARK: - Properties

    private let repository: OnboardingRepositoryProtocol

    // MARK: - Initialization

    public init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() {
        repository.saveOnboardingCompleted()
    }
}
