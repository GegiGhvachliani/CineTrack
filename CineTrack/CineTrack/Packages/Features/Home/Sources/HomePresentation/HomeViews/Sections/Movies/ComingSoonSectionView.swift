//
//  ComingSoonSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import SharedCore

struct ComingSoonSectionView: View {
    
    let movies: [Movie]
    let watchlistedMovies: [Movie]

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void
    
    var body: some View {
        
        HorizontalScrollView(
            headerText: HomeStrings.Section.upcoming,
            items: movies,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore)
        { movie, _ in
            
            ComingSoonMoviesCell(
                movie: movie,
                isWatchlisted: watchlistedMovies.contains {
                    $0.id == movie.id
                },
                cellHeight: 265,
                onMovieTap: { onMovieTap(movie) },
                onWatchlistTap: { onWatchlistTap(movie)
                }
            )
            
        }
    }
    
}
