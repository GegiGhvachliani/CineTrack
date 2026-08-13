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
    let watchlistedMovies: [Movie]

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void
    
    var body: some View {
        
        HorizontalScrollView(
            headerText: HomeStrings.Section.trending,
            items: movies,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        ) { movie, _ in
            
            MovieCell(
                movie: movie,
                isWatchlisted: watchlistedMovies.contains {
                    $0.id == movie.id
                },
                cellHeight: 240,
                onMovieTap: { onMovieTap(movie) },
                onWatchlistTap: { onWatchlistTap(movie) }
            )
            
        }
    }
    
}
