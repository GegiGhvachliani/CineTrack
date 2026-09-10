//
//  OnboardingStep.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

public enum OnboardingStep: Int, CaseIterable {
    case discover
    case watchlist
    case preferences

    public var isLast: Bool {
        self == .preferences
    }
}
