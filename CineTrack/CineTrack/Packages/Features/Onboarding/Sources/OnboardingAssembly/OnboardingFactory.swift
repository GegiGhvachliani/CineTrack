//
//  OnboardingFactory.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import UIKit
import SwiftUI
import OnboardingPresentation
import OnboardingPresentationAPI

public struct OnboardingFactory: OnboardingFactoryProtocol {
    
    public init() {}
    
    public func makeOnboardingViewController(didComplete: @escaping () -> Void) -> UIViewController {
        // ჯერჯერობით მარტივი ეკრანი სანამ ვიზუალს ავაწყობ
        let viewModel = OnboardingViewModel(didComplete: didComplete)
        let onboardingView = OnboardingView(viewModel: viewModel)
        
        let hostingController = UIHostingController(rootView: onboardingView)
        
        return hostingController
    }
    
    public func makeOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinatorProtocol {
        return OnboardingCoordinator(navigationController: navigationController, factory: self)
    }
}
