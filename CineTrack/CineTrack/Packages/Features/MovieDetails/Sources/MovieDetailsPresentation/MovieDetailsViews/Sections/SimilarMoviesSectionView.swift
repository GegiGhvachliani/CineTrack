import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct SimilarMoviesSectionView: View {

    // MARK: - Properties

    let movies: [Movie]
    let isWatchlisted: (Movie) -> Bool
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        if !movies.isEmpty {
            HorizontalScrollView(
                headerText: MovieDetailsStrings.Content.moreLikeThis,
                seeAllTitle: MovieDetailsStrings.Content.seeAll,
                items: movies,
                showsSeeAllButton: true,
                onSeeAllTap: onSeeAllTap
            ) { movie, _ in
                MovieCell(
                    movie: movie,
                    isWatchlisted: isWatchlisted(movie),
                    cellHeight: 240,
                    onMovieTap: { onMovieTap(movie) },
                    onWatchlistTap: { onWatchlistTap(movie) }
                )
            }
        }
    }
}
