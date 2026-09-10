import Combine
import Foundation
import Observation
import LibraryDomain
import SearchDomain
import SharedCore

extension SearchViewModel {

    // MARK: - Personalization

    public func loadPersonalization() async {
        async let watchlistedMovies = fetchWatchlistedMoviesUseCase.execute()
        async let favouritedActors = fetchFavouritedActorsUseCase.execute()

        do {
            watchlistedMovieIDs = Set(try await watchlistedMovies.map(\.id))
            favouritedActorIDs = Set(try await favouritedActors.map(\.id))
        } catch {
            print("❌ Search Personalization Error:", error)
        }
    }

    public func toggleWatchlist(for movie: Movie) async {
        guard pendingWatchlistIDs.insert(movie.id).inserted else {
            return
        }

        defer {
            pendingWatchlistIDs.remove(movie.id)
        }

        let wasWatchlisted = watchlistedMovieIDs.contains(movie.id)

        if wasWatchlisted {
            watchlistedMovieIDs.remove(movie.id)
        } else {
            watchlistedMovieIDs.insert(movie.id)
        }

        do {
            if wasWatchlisted {
                try await removeWatchlistedMovieUseCase.execute(movie: movie)
            } else {
                try await addWatchlistedMovieUseCase.execute(movie: movie)
            }
        } catch {
            if wasWatchlisted {
                watchlistedMovieIDs.insert(movie.id)
            } else {
                watchlistedMovieIDs.remove(movie.id)
            }

            print("❌ Search Watchlist Error:", error)
        }
    }

    public func toggleFavourite(for actor: Actor) async {
        guard pendingFavouriteIDs.insert(actor.id).inserted else {
            return
        }

        defer {
            pendingFavouriteIDs.remove(actor.id)
        }

        let wasFavourited = favouritedActorIDs.contains(actor.id)

        if wasFavourited {
            favouritedActorIDs.remove(actor.id)
        } else {
            favouritedActorIDs.insert(actor.id)
        }

        do {
            if wasFavourited {
                try await removeFavouritedActorUseCase.execute(actor: actor)
            } else {
                try await addFavouritedActorUseCase.execute(actor: actor)
            }
        } catch {
            if wasFavourited {
                favouritedActorIDs.insert(actor.id)
            } else {
                favouritedActorIDs.remove(actor.id)
            }

            print("❌ Search Favourite Error:", error)
        }
    }
}
