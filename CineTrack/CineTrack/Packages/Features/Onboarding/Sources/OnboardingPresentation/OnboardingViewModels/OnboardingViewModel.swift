//
//  OnboardingViewModel.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import Foundation
import Observation
import OnboardingDomain

@Observable
@MainActor
public final class OnboardingViewModel: OnboardingViewModelProtocol {

    // MARK: - Properties

    public internal(set) var currentStep: OnboardingStep = .discover

    internal let finishOnboardingUseCase: FinishOnboardingUseCaseProtocol
    internal let didComplete: () -> Void

    public var isLastStep: Bool {
        currentStep.isLast
    }

    // MARK: - Initialization

    public init(
        finishOnboardingUseCase: FinishOnboardingUseCaseProtocol,
        didComplete: @escaping () -> Void
    ) {
        self.finishOnboardingUseCase = finishOnboardingUseCase
        self.didComplete = didComplete
    }

}
