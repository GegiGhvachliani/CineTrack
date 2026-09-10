import Foundation
import LibraryDomain
import Observation
import ProfileDomain
import SharedCore

extension ProfileViewModel {

    // MARK: - Watchlist

    public func toggleWatchlist(_ movie: Movie) async {
        guard !isSigningOut else { return }
        let key = "movie-\(movie.id)"
        guard pendingItems.insert(key).inserted else { return }
        defer { pendingItems.remove(key) }
        do {
            if movies.contains(where: { $0.id == movie.id }) {
                try await removeWatchlistedMovieUseCase.execute(movie: movie)
                movies.removeAll { $0.id == movie.id }
            } else {
                try await addWatchlistedMovieUseCase.execute(movie: movie)
                movies.insert(movie, at: 0)
            }
        } catch {
            errorMessage = error is ProfileError ? ProfileStrings.Content.invalidPhoto : error.localizedDescription
        }
    }
}
