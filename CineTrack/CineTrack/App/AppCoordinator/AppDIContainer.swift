//
//  AppDIContainer.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 23/06/2026.
//

import Foundation
import HomeAssembly
import HomePresentationAPI
import ProfileAssembly
import ProfilePresentationAPI
import SearchAssembly
import SearchPresentationAPI
import OnboardingAssembly
import OnboardingPresentationAPI
import AuthenticationAssembly
import AuthenticationPresentationAPI
import ActorDetailsAssembly
import ActorDetailsPresentationAPI
import MovieDetailsAssembly
import MovieDetailsPresentationAPI
import NewsDetailsAssembly
import NewsDetailsPresentationAPI
import SeeAllAssembly
import SeeAllPresentationAPI
import VideosListAssembly
import VideosListPresentationAPI
import UIKit


final class AppDIContainer: AppDIContainerProtocol {
    lazy var homeFactory: HomeFactoryProtocol = HomeFactory()
    lazy var profileFactory: ProfileFactoryProtocol = ProfileFactory()
    lazy var searchFactory: SearchFactoryProtocol = SearchFactory()
    lazy var onboardingFactory: OnboardingFactoryProtocol = OnboardingFactory()
    lazy var authenticationFactory: AuthenticationFactoryProtocol = AuthenticationFactory()
    lazy var actorDetailsFactory: ActorDetailsFactoryProtocol = ActorDetailsFactory()
    lazy var movieDetailsFactory: MovieDetailsFactoryProtocol = MovieDetailsFactory()
    lazy var newsDetailsFactory: NewsDetailsFactoryProtocol = NewsDetailsFactory()
    lazy var seeAllFactory: SeeAllFactoryProtocol = SeeAllFactory()
    lazy var videosListFactory: VideosListFactoryProtocol = VideosListFactory()

    init() {}
}
