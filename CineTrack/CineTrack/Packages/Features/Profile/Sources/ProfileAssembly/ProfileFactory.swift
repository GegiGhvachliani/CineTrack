//
//  ProfileFactory.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import LibraryDomain
import LibraryData
import ProfileDomain
import ProfileData
import ProfilePresentation
import ProfilePresentationAPI
import SharedAuth
import SharedStorage
import SwiftUI
import UIKit

public struct ProfileFactory: ProfileFactoryProtocol {

    // MARK: - Dependencies

    private let firestore: RemoteDocumentStore
    private let session: AccountSession

    // MARK: - Initialization

    public init(firestore: RemoteDocumentStore, session: AccountSession) {
        self.firestore = firestore
        self.session = session
    }

    public func makeProfileViewController(router: ProfileRoutingProtocol) -> UIViewController {

        // MARK: - Repositories

        let accountRepository: ProfileRepositoryProtocol = ProfileRepository(
            firestore: firestore,
            accountSession: session,
            photoProcessor: ImageIOProfilePhotoProcessor()
        )
        let watchlistRepository: WatchlistRepositoryProtocol = WatchlistRepository(
            firestore: firestore, userSession: session)
        let favouriteRepository: FavouriteRepositoryProtocol = FavouriteRepository(
            firestore: firestore, userSession: session)
        let recentlyViewedRepository: RecentlyViewedRepositoryProtocol = RecentlyViewedRepository(
            firestore: firestore, userSession: session)

        // MARK: - Use Cases

        let fetchProfileUseCase: FetchProfileUseCaseProtocol = FetchProfileUseCase(repository: accountRepository)

        let updateProfilePhotoUseCase: UpdateProfilePhotoUseCaseProtocol = UpdateProfilePhotoUseCase(
            repository: accountRepository)

        let signOutUseCase: SignOutUseCaseProtocol = SignOutUseCase(repository: accountRepository)

        let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol = FetchWatchlistedMoviesUseCase(
            repository: watchlistRepository)

        let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol = AddWatchlistedMovieUseCase(
            repository: watchlistRepository)

        let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol = RemoveWatchlistedMovieUseCase(
            repository: watchlistRepository)

        let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol = FetchFavouritedActorsUseCase(
            repository: favouriteRepository)

        let addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol = AddFavouritedActorUseCase(
            repository: favouriteRepository)

        let removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol = RemoveFavouritedActorUseCase(
            repository: favouriteRepository)

        let fetchRecentlyViewedMoviesUseCase: FetchRecentlyViewedMoviesUseCaseProtocol =
            FetchRecentlyViewedMoviesUseCase(repository: recentlyViewedRepository)

        let fetchRecentlyViewedActorsUseCase: FetchRecentlyViewedActorsUseCaseProtocol =
            FetchRecentlyViewedActorsUseCase(repository: recentlyViewedRepository)

        let clearRecentlyViewedUseCase: ClearRecentlyViewedUseCaseProtocol = ClearRecentlyViewedUseCase(
            repository: recentlyViewedRepository)

        // MARK: - ViewModel

        let viewModel = ProfileViewModel(
            fetchProfileUseCase: fetchProfileUseCase,
            updateProfilePhotoUseCase: updateProfilePhotoUseCase,
            signOutUseCase: signOutUseCase,
            fetchWatchlistedMoviesUseCase: fetchWatchlistedMoviesUseCase,
            addWatchlistedMovieUseCase: addWatchlistedMovieUseCase,
            removeWatchlistedMovieUseCase: removeWatchlistedMovieUseCase,
            fetchFavouritedActorsUseCase: fetchFavouritedActorsUseCase,
            addFavouritedActorUseCase: addFavouritedActorUseCase,
            removeFavouritedActorUseCase: removeFavouritedActorUseCase,
            fetchRecentlyViewedMoviesUseCase: fetchRecentlyViewedMoviesUseCase,
            fetchRecentlyViewedActorsUseCase: fetchRecentlyViewedActorsUseCase,
            clearRecentlyViewedUseCase: clearRecentlyViewedUseCase
        )

        // MARK: - Actions

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
