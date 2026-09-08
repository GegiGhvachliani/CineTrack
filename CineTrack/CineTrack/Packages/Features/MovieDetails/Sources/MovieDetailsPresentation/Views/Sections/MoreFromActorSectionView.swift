import SwiftUI

import DesignSystemComponents
import SharedCore

struct MoreFromActorSectionView: View {
    let actorName: String
    let movies: [Movie]
    let isWatchlisted: (Movie) -> Bool
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void

    var body: some View {
        HorizontalScrollView(
            headerText: "More From \(actorName)",
            seeAllTitle: "See All",
            items: movies,
            showsSeeAllButton: false
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
