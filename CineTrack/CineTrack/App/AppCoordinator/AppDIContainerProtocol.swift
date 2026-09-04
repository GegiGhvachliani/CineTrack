//
//  AppDIContainerProtocol.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import Foundation
import HomePresentationAPI
import ProfilePresentationAPI
import SearchPresentationAPI
import OnboardingPresentationAPI
import AuthenticationPresentationAPI
import ActorDetailsPresentationAPI
import MovieDetailsPresentationAPI
import NewsDetailsPresentationAPI
import SeeAllPresentationAPI
import VideosListPresentationAPI

@MainActor
protocol AppDIContainerProtocol {
    var homeFactory: HomeFactoryProtocol { get }
    var profileFactory: ProfileFactoryProtocol { get }
    var searchFactory: SearchFactoryProtocol { get }
    var onboardingFactory: OnboardingFactoryProtocol { get }
    var authenticationFactory: AuthenticationFactoryProtocol { get }
    var actorDetailsFactory: ActorDetailsFactoryProtocol { get }
    var movieDetailsFactory: MovieDetailsFactoryProtocol { get }
    var newsDetailsFactory: NewsDetailsFactoryProtocol { get }
    var seeAllFactory: SeeAllFactoryProtocol { get }
    var videosListFactory: VideosListFactoryProtocol { get }
}
