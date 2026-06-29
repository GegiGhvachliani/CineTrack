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

extension OnboardingStep {
    public var imageTitle: String {
        switch self {
        case .discover: return OnboardingStrings.Discover.imageTitle
        case .watchlist: return OnboardingStrings.Watchlist.imageTitle
        case .preferences: return OnboardingStrings.Preferences.imageTitle
        }
    }
    
        public var appTitle: String {
        switch self {
        default: return "CineTrack"
        }
    }
    
        public var title: String {
        switch self {
        case .discover: return OnboardingStrings.Discover.title
        case .watchlist: return OnboardingStrings.Watchlist.title
        case .preferences: return OnboardingStrings.Preferences.title
        }
    }
    
        public var subtitle: String {
        switch self {
        case .discover: return OnboardingStrings.Discover.subtitle
        case .watchlist: return OnboardingStrings.Watchlist.subtitle
        case .preferences: return OnboardingStrings.Preferences.subtitle
        }
    }
    
    public var buttonText: String {
        switch self {
        case .discover: return OnboardingStrings.Discover.buttonText
        case .watchlist: return OnboardingStrings.Watchlist.buttonText
        case .preferences: return OnboardingStrings.Preferences.buttonText
        }
    }
    
}
