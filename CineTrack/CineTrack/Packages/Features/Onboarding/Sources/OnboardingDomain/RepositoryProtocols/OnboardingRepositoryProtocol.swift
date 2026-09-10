//
//  OnboardingRepositoryProtocol.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 29/06/2026.
//

public protocol OnboardingRepositoryProtocol: Sendable {
    func saveOnboardingCompleted()
    func isOnboardingCompleted() -> Bool
}
