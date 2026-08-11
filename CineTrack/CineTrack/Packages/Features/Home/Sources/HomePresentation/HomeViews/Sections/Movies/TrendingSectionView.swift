//
//  TrendingSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import SharedCore

struct TrendingSectionView: View {
    
    let movies: [Movie]
    let watchlistedMovieID: Set<Int>
    
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void
    
    var body: some View {
        
        HorizontalScrollView(
            headerText: "Trending now",
            items: movies,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        ) { movie, _ in
            
            MovieCell(
                movie: movie,
                isWatchlisted: watchlistedMovieID.contains(movie.id),
                cellHeight: 240,
                onMovieTap: { onMovieTap(movie) },
                onWatchlistTap: { onWatchlistTap(movie) }
            )
            
        }
    }
    
}
