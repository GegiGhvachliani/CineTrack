//
//  ComingSoonSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import DesignSystemComponents

struct ComingSoonSectionView: View {

    // MARK: - Properties

    let movies: [Movie]
    let watchlistedMovies: [Movie]

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void

    // MARK: - Body

    var body: some View {

        HorizontalScrollView(
            headerText: HomeStrings.Section.upcoming,
            seeAllTitle: HomeStrings.Action.seeAll,
            items: movies,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        ) { movie, _ in

            ComingSoonMoviesCell(
                movie: movie,
                isWatchlisted: watchlistedMovies.contains {
                    $0.id == movie.id
                },
                cellHeight: 265,
                onMovieTap: { onMovieTap(movie) },
                onWatchlistTap: {
                    onWatchlistTap(movie)
                }
            )

        }
    }

}
