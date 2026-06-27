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
    var selectedGenres: Set<Genre> { get }
    var isLastStep: Bool { get }
    var currentIndex: Int { get }
    
    func next()
    func back()
    func toggleGenre(_ genre: Genre)
    func finish()
}

public final class OnboardingViewModel: OnboardingViewModelProtocol {
    @Published public private(set) var currentStep: OnboardingStep = .discover
    @Published public private(set) var selectedGenres: Set<Genre> = []
    
    public var isLastStep: Bool {
        currentStep.isLast
    }
    
    public var currentIndex: Int {
        currentStep.rawValue
    }
    
   public func next() {}
   public func back() {}
   public func toggleGenre(_ genre: Genre) {}
   public func finish() {}
}
