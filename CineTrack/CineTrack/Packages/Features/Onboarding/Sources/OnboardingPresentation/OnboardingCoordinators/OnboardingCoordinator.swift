//
//  OnboardingCoordinator.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import OnboardingPresentationAPI
import SharedCore
import UIKit

public final class OnboardingCoordinator: OnboardingCoordinatorProtocol {

    // MARK: - Properties
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public let factory: OnboardingFactoryProtocol

    public var onFinish: (() -> Void)?

    // MARK: - Initializations
    public init(
        navigationController: UINavigationController,
        factory: OnboardingFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    // MARK: - Methods
    public func start() {
        let onboardingVC = factory.makeOnboardingViewController { [weak self] in
            self?.finishOnboarding()
        }
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([onboardingVC], animated: true)
    }
    
    private func finishOnboarding() {
        onFinish?()
    }
}
