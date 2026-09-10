//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import Foundation
import LibraryDomain
import Observation
import ProfileDomain
import SharedCore

@Observable
@MainActor
public final class ProfileViewModel: ProfileViewModelProtocol {

    // MARK: - Content

    public internal(set) var account: ProfileAccount?
    public internal(set) var movies: [Movie] = []
    public internal(set) var actors: [Actor] = []
    public internal(set) var recentlyViewed: [RecentlyViewedItem] = []
    public internal(set) var isLoading = false
    public internal(set) var hasLoaded = false
    public internal(set) var isUpdatingPhoto = false
    public internal(set) var isSigningOut = false
    public var errorMessage: String?
    internal var pendingItems = Set<String>()

    // MARK: - Navigation

    public var onMovieTap: ((Movie) -> Void)?
    public var onActorTap: ((Int) -> Void)?
    public var onSeeAll: ((SeeAllContent) -> Void)?
    public var onSignedOut: (() -> Void)?

    // MARK: - Dependencies (UseCases)

    internal let fetchProfileUseCase: FetchProfileUseCaseProtocol
    internal let updateProfilePhotoUseCase: UpdateProfilePhotoUseCaseProtocol
    internal let signOutUseCase: SignOutUseCaseProtocol
    internal let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol
    internal let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol
    internal let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol
    internal let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol
    internal let addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol
    internal let removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol
    internal let fetchRecentlyViewedMoviesUseCase: FetchRecentlyViewedMoviesUseCaseProtocol
    internal let fetchRecentlyViewedActorsUseCase: FetchRecentlyViewedActorsUseCaseProtocol
    internal let clearRecentlyViewedUseCase: ClearRecentlyViewedUseCaseProtocol

    // MARK: - Initialization

    public init(
        fetchProfileUseCase: FetchProfileUseCaseProtocol,
        updateProfilePhotoUseCase: UpdateProfilePhotoUseCaseProtocol,
        signOutUseCase: SignOutUseCaseProtocol,
        fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol,
        addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol,
        removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol,
        fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol,
        addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol,
        removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol,
        fetchRecentlyViewedMoviesUseCase: FetchRecentlyViewedMoviesUseCaseProtocol,
        fetchRecentlyViewedActorsUseCase: FetchRecentlyViewedActorsUseCaseProtocol,
        clearRecentlyViewedUseCase: ClearRecentlyViewedUseCaseProtocol
    ) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.updateProfilePhotoUseCase = updateProfilePhotoUseCase
        self.signOutUseCase = signOutUseCase
        self.fetchWatchlistedMoviesUseCase = fetchWatchlistedMoviesUseCase
        self.addWatchlistedMovieUseCase = addWatchlistedMovieUseCase
        self.removeWatchlistedMovieUseCase = removeWatchlistedMovieUseCase
        self.fetchFavouritedActorsUseCase = fetchFavouritedActorsUseCase
        self.addFavouritedActorUseCase = addFavouritedActorUseCase
        self.removeFavouritedActorUseCase = removeFavouritedActorUseCase
        self.fetchRecentlyViewedMoviesUseCase = fetchRecentlyViewedMoviesUseCase
        self.fetchRecentlyViewedActorsUseCase = fetchRecentlyViewedActorsUseCase
        self.clearRecentlyViewedUseCase = clearRecentlyViewedUseCase
    }

}
