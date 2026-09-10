//
//  OnboardingViewModel+Actions.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import Foundation
import Observation
import OnboardingDomain

extension OnboardingViewModel {

    // MARK: - Actions

    public func next() {
        guard let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1)
        else { return }
        currentStep = nextStep
    }

    public func finish() {
        finishOnboardingUseCase.execute()
        didComplete()
    }
}
