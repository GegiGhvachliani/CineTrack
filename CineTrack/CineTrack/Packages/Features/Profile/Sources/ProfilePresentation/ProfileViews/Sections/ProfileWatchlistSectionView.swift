import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct ProfileWatchlistSectionView: View {

    // MARK: - Properties

    let movies: [Movie]
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        if movies.isEmpty {
            ProfileEmptySectionView(
                title: ProfileStrings.Content.watchlisted,
                message: ProfileStrings.Content.yourWatchlistIsWaitingForItsFirstMovie,
                detail: ProfileStrings.Content.tapTheBookmarkOnAMovieToSave
            )
        } else {
            WatchlistedMoviesSectionView(
                title: ProfileStrings.Content.watchlisted,
                movies: movies,
                watchlistedMovies: movies,
                onMovieTap: onMovieTap,
                onWatchlistTap: { movie in
                    onWatchlistTap(movie)
                },
                onSeeAllTap: onSeeAllTap,
                onLoadMore: {}
            )
        }
    }
}
