//
//  OnboardingRepository.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 29/06/2026.
//

import OnboardingDomain
import Foundation

public final class OnboardingRepository: OnboardingRepositoryProtocol {
    private let userDefaultsKey = "hasCompletedOnboarding"
    
    public init() {}
    
    public func saveOnboardingCompleted() {
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
    }
    
    public func isOnboardingCompleted() -> Bool {
        UserDefaults.standard.bool(forKey: userDefaultsKey)
    }
}
