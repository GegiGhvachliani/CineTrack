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
    private let repository: OnboardingRepositoryProtocol
    
    public init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() {
        repository.saveOnboardingCompleted()
    }
}
