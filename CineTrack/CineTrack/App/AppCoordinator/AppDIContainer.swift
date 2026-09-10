//
//  AppDIContainer.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 23/06/2026.
//

import Foundation
import SharedNetworking
import SharedStorage
import SharedAuth
import TMDBData
import NewsData
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

    // MARK: - Properties

    lazy var homeFactory: HomeFactoryProtocol = HomeFactory(
        apiClient: apiClient,
        configuration: configuration.tmdb,
        newsConfiguration: configuration.news,
        firestore: firestore,
        userSession: userSession
    )
    lazy var profileFactory: ProfileFactoryProtocol = ProfileFactory(firestore: firestore, session: userSession)
    lazy var searchFactory: SearchFactoryProtocol = SearchFactory(
        apiClient: apiClient,
        configuration: configuration.tmdb,
        firestore: firestore,
        userSession: userSession
    )
    lazy var onboardingFactory: OnboardingFactoryProtocol = OnboardingFactory()
    lazy var authenticationFactory: AuthenticationFactoryProtocol = AuthenticationFactory()
    lazy var actorDetailsFactory: ActorDetailsFactoryProtocol = ActorDetailsFactory(
        apiClient: apiClient,
        tmdbConfiguration: configuration.tmdb,
        newsConfiguration: configuration.news,
        firestore: firestore,
        userSession: userSession
    )
    lazy var movieDetailsFactory: MovieDetailsFactoryProtocol = MovieDetailsFactory(
        apiClient: apiClient,
        tmdbConfiguration: configuration.tmdb,
        newsConfiguration: configuration.news,
        firestore: firestore,
        userSession: userSession
    )
    lazy var newsDetailsFactory: NewsDetailsFactoryProtocol = NewsDetailsFactory()
    lazy var seeAllFactory: SeeAllFactoryProtocol = SeeAllFactory()
    lazy var videosListFactory: VideosListFactoryProtocol = VideosListFactory(
        apiClient: apiClient,
        configuration: configuration.tmdb
    )

    // MARK: - Shared Dependencies

    private let configuration: AppConfigurationProtocol
    private let apiClient: APIClient
    private let firestore: RemoteDocumentStore
    private let userSession: AccountSession

    // MARK: - Initialization

    init(
        configuration: AppConfigurationProtocol = AppConfiguration(),
        apiClient: APIClient = URLSessionAPIClient(),
        firestore: RemoteDocumentStore = FirestoreClient(),
        userSession: AccountSession = FirebaseUserSession()
    ) {
        self.configuration = configuration
        self.apiClient = apiClient
        self.firestore = firestore
        self.userSession = userSession
    }
}
