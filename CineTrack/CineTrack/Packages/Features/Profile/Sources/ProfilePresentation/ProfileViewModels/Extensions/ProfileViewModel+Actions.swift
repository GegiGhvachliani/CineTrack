import Foundation
import LibraryDomain
import Observation
import ProfileDomain
import SharedCore

extension ProfileViewModel {

    // MARK: - Actions

    public func didTapMovie(_ movie: Movie) {
        onMovieTap?(movie)
    }

    public func didTapActor(_ actor: Actor) {
        onActorTap?(actor.id)
    }

    public func showFavourites() {
        onSeeAll?(SeeAllContent(title: ProfileStrings.Content.favourited, payload: .actors(actors)))
    }

    public func showWatchlist() {
        onSeeAll?(SeeAllContent(title: ProfileStrings.Content.watchlisted, payload: .movies(movies)))
    }
}
