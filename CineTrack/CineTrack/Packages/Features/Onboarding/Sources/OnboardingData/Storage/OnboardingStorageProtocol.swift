//
//  OnboardingFactory.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

public protocol OnboardingStorageProtocol: Sendable {
    func isCompleted() -> Bool
    func setCompleted()
}
