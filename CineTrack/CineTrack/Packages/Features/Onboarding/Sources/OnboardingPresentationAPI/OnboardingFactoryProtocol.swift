//
//  OnboardingFactoryProtocol.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import UIKit

@MainActor
public protocol OnboardingFactoryProtocol {
    func makeOnboardingViewController(didComplete: @escaping () -> Void) -> UIViewController
    func makeOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinatorProtocol

    func isOnboardingCompleted() -> Bool
}
