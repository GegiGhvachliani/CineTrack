//
//  OnboardingRepository.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 29/06/2026.
//

import OnboardingDomain
import Foundation

public final class OnboardingRepository: OnboardingRepositoryProtocol {
    // MARK: - Properties
    private let userDefaultsKey = "hasCompletedOnboarding"
    
    // MARK: - Initializations
    
    public init() {}
    
    // MARK: - Methods
    
    public func saveOnboardingCompleted() {
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
    }
    
    public func isOnboardingCompleted() -> Bool {
        UserDefaults.standard.bool(forKey: userDefaultsKey)
    }
}
