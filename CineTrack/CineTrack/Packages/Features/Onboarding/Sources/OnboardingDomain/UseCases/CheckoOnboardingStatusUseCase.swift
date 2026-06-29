//
//  CheckoOnboardingStatusUseCase.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 29/06/2026.
//

public protocol CheckoOnboardingStatusUseCaseProtocol {
    func execute() -> Bool
}

public final class CheckoOnboardingStatusUseCase: CheckoOnboardingStatusUseCaseProtocol {
    private let repository: OnboardingRepositoryProtocol
    
    public init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> Bool {
        repository.isOnboardingCompleted()
    }
}
