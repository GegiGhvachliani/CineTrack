//
//  Top10SectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemComponents

struct Top10SectionView: View {

    let movies: [Movie]
    let watchlistedMovies: [Movie]

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void

    var body: some View {
        HorizontalScrollView(
            headerText: HomeStrings.Section.top10,
            seeAllTitle: HomeStrings.Action.seeAll,
            items: movies,
            onSeeAllTap: onSeeAllTap
        ) { movie, index in

            Top10MovieCell(
                movie: movie,
                isWatchlisted: watchlistedMovies.contains {
                    $0.id == movie.id
                },
                cellHeight: 265,
                ratingNumber: index + 1,
                onMovieTap: { onMovieTap(movie) },
                onWatchlistTap: { onWatchlistTap(movie)
                }
            )
            
        }
    }
}
