//
//  ProfileViewModelProtocol.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import Foundation
import LibraryDomain
import Observation
import ProfileDomain
import SharedCore

@MainActor
public protocol ProfileViewModelProtocol: AnyObject, Observable {

    // MARK: - State & Actions

    var account: ProfileAccount? { get }
    var movies: [Movie] { get }
    var actors: [Actor] { get }
    var recentlyViewed: [RecentlyViewedItem] { get }
    var isLoading: Bool { get }
    var hasLoaded: Bool { get }
    var isUpdatingPhoto: Bool { get }
    var isSigningOut: Bool { get }
    var errorMessage: String? { get set }
    var onMovieTap: ((Movie) -> Void)? { get set }
    var onActorTap: ((Int) -> Void)? { get set }
    var onSeeAll: ((SeeAllContent) -> Void)? { get set }
    var onSignedOut: (() -> Void)? { get set }

    // MARK: - Methods

    func didTapMovie(_ movie: Movie)
    func didTapActor(_ actor: Actor)
    func showFavourites()
    func showWatchlist()

    func load() async
    func toggleWatchlist(_ movie: Movie) async
    func toggleFavourite(_ actor: Actor) async
    func clearHistory() async
    func savePhoto(_ data: Data) async
    func signOut() async
    func showHistory()
}
