//
//  Top10SectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import SharedCore

struct Top10SectionView: View {

    let movies: [Movie]
    let watchlistedMovieIDs: Set<Int>

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void

    var body: some View {
        HorizontalScrollView(
            headerText: "Top 10 in CineTrack this week",
            items: movies,
            onSeeAllTap: onSeeAllTap
        ) { movie, index in

            Top10MovieCell(
                movie: movie,
                isWatchlisted: watchlistedMovieIDs.contains(movie.id),
                cellHeight: 265,
                ratingNumber: index + 1,
                onMovieTap: { onMovieTap(movie) },
                onWatchlistTap: { onWatchlistTap(movie)
                }
            )
            
        }
    }
    
}
