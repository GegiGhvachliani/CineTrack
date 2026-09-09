//
//  ProfileFactory.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import HomeData
import ProfileData
import ProfilePresentation
import ProfilePresentationAPI
import SharedAuth
import SharedStorage
import SwiftUI
import UIKit

public struct ProfileFactory: ProfileFactoryProtocol {

    public init() {}

    public func makeProfileViewController(router: ProfileRoutingProtocol) -> UIViewController {
        let firestore = FirestoreClient()
        let session = FirebaseUserSession()
        let viewModel = ProfileViewModel(
            accountRepository: ProfileRepository(firestore: firestore),
            watchlist: WatchlistRepository(firestore: firestore, userSession: session),
            favourites: FavouriteRepository(firestore: firestore, userSession: session),
            history: RecentlyViewedRepository(firestore: firestore, userSession: session)
        )
        viewModel.onMovieTap = { [weak router] in router?.showMovieDetails(movie: $0) }
        viewModel.onActorTap = { [weak router] in router?.showActorDetails(actorID: $0) }
        viewModel.onSeeAll = { [weak router] in router?.showSeeAll(content: $0) }
        viewModel.onSignedOut = { [weak router] in router?.didSignOut() }
        return UIHostingController(rootView: ProfileView(viewModel: viewModel))
    }

    public func makeProfileCoordinator(
        navigationController: UINavigationController,
        router: ProfileRoutingProtocol
    ) -> ProfileCoordinatorProtocol {
        return ProfileCoordinator(navigationController: navigationController, factory: self, router: router)
    }
}
