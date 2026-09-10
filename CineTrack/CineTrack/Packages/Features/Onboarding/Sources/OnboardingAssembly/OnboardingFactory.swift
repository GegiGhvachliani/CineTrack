//
//  OnboardingFactory.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import UIKit
import SwiftUI
import OnboardingDomain
import OnboardingData
import OnboardingPresentation
import OnboardingPresentationAPI

public struct OnboardingFactory: OnboardingFactoryProtocol {

    // MARK: - Initialization

    public init() {}

    public func isOnboardingCompleted() -> Bool {
        let repository = OnboardingRepository(storage: UserDefaultsOnboardingStorage())
        let useCase = CheckOnboardingStatusUseCase(repository: repository)
        return useCase.execute()
    }

    // MARK: - Methods

    public func makeOnboardingViewController(didComplete: @escaping () -> Void) -> UIViewController {
        let repository: OnboardingRepositoryProtocol = OnboardingRepository(storage: UserDefaultsOnboardingStorage())
        let finishUseCase: FinishOnboardingUseCaseProtocol = FinishOnboardingUseCase(repository: repository)

        let viewModel = OnboardingViewModel(
            finishOnboardingUseCase: finishUseCase,
            didComplete: didComplete
        )

        let onboardingView = OnboardingView(viewModel: viewModel)

        return UIHostingController(rootView: onboardingView)
    }

    public func makeOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinatorProtocol {
        return OnboardingCoordinator(navigationController: navigationController, factory: self)
    }
}
