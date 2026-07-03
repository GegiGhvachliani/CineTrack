//
//  OnboardingViewModel.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import Foundation
import OnboardingDomain

@MainActor
public protocol OnboardingViewModelProtocol: ObservableObject {
    var currentStep: OnboardingStep { get }
    var isLastStep: Bool { get }

    func next()
    func finish()
}


public final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    // MARK: - Properties

    @Published public private(set) var currentStep: OnboardingStep = .discover

    private let finishOnboardingUseCase: FinishOnboardingUseCaseProtocol
    private let didComplete: () -> Void

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
    
    // MARK: - Methods

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
