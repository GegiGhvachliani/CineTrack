//
//  CheckoOnboardingStatusUseCase.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 29/06/2026.
//

public protocol CheckOnboardingStatusUseCaseProtocol {
    func execute() -> Bool
}

public final class CheckOnboardingStatusUseCase: CheckOnboardingStatusUseCaseProtocol {
    private let repository: OnboardingRepositoryProtocol
    
    public init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> Bool {
        repository.isOnboardingCompleted()
    }
}
