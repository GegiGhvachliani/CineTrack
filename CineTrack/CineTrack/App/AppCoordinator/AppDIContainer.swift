//
//  AppDIContainer.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 23/06/2026.
//

import Foundation
import HomeAssembly
import ProfileAssembly
import SearchAssembly
import OnboardingAssembly
import HomePresentationAPI
import ProfilePresentationAPI
import SearchPresentationAPI
import OnboardingPresentationAPI
import UIKit

final class AppDIContainer: AppDIContainerProtocol {
    lazy var homeFactory: HomeFactoryProtocol = HomeFactory()
    lazy var profileFactory: ProfileFactoryProtocol = ProfileFactory()
    lazy var searchFactory: SearchFactoryProtocol = SearchFactory()
    lazy var onboardingFactory: OnboardingFactoryProtocol = OnboardingFactory()

    init() {}
}
