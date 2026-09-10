//
//  OnboardingViewModelProtocol.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import Observation
import OnboardingDomain

@MainActor
public protocol OnboardingViewModelProtocol: AnyObject, Observable {
    var currentStep: OnboardingStep { get }
    var isLastStep: Bool { get }

    func next()
    func finish()
}
