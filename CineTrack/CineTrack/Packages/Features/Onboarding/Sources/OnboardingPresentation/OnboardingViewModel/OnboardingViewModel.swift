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
    var currentIndex: Int { get }

    func next()
    func back()
    func finish()
}

public final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    private let finishOnboardingUseCase: FinishOnboardingUseCaseProtocol
    private let didComplete: () -> Void
    
    public var isLastStep: Bool {
        currentStep.isLast
    }

    public var currentIndex: Int {
        currentStep.rawValue
    }
    

    @Published public private(set) var currentStep: OnboardingStep = .discover

    public init(
        finishOnboardingUseCase: FinishOnboardingUseCaseProtocol,
        didComplete: @escaping () -> Void
    ) {
        self.finishOnboardingUseCase = finishOnboardingUseCase
        self.didComplete = didComplete
    }

    public func next() {
        guard let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) else {
            return
        }

        currentStep = nextStep
    }

    public func back() {
        guard let previousStep = OnboardingStep(rawValue: currentStep.rawValue - 1) else {
            return
        }

        currentStep = previousStep
    }
    
    public func finish() {
        finishOnboardingUseCase.execute()
        
        didComplete()
    }
}
