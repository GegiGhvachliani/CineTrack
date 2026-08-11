//
//  FanFavouritesSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import SharedCore

struct FanFavouritesSectionView: View {

    let movies: [Movie]
    let watchlistedMovieIDs: Set<Int>

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void

    var body: some View {
        
        HorizontalScrollView(
            headerText: "Fan Favourites",
            items: movies,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        ) { movie, _ in

            MovieCell(
                movie: movie,
                isWatchlisted: watchlistedMovieIDs.contains(movie.id),
                cellHeight: 240,
                onMovieTap: { onMovieTap(movie) },
                onWatchlistTap: { onWatchlistTap(movie) }
            )
        }
    }
    
}
