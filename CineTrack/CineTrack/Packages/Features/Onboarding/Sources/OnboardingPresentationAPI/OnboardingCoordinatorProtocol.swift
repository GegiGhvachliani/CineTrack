//
//  OnboardingCoordinatorProtocol.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import UIKit
import SharedCore

public protocol OnboardingCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get }
}
