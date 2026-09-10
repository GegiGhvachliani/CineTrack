import Foundation
import LibraryDomain
import Observation
import ProfileDomain
import SharedCore

extension ProfileViewModel {

    // MARK: - History

    public func clearHistory() async {
        guard !isSigningOut else { return }
        guard pendingItems.insert("history").inserted else { return }
        defer { pendingItems.remove("history") }
        do {
            try await clearRecentlyViewedUseCase.execute()
            recentlyViewed = []
        } catch {
            errorMessage = error is ProfileError ? ProfileStrings.Content.invalidPhoto : error.localizedDescription
        }
    }

    public func showHistory() {
        let items = recentlyViewed.map { item -> SeeAllLibraryItem in
            switch item {
            case .movie(let movie):
                return .movie(
                    Movie(
                        id: movie.id,
                        title: movie.title,
                        overview: "",
                        posterPath: movie.posterPath,
                        backdropPath: nil,
                        releaseDate: movie.releaseDate,
                        voteAverage: movie.voteAverage,
                        voteCount: 0
                    )
                )
            case .actor(let actor):
                return .actor(
                    Actor(
                        id: actor.id,
                        name: actor.name,
                        birthday: actor.birthday,
                        profilePath: actor.profilePath
                    )
                )
            }
        }
        onSeeAll?(SeeAllContent(title: ProfileStrings.Content.recentlyViewed, payload: .library(items)))
    }
}
