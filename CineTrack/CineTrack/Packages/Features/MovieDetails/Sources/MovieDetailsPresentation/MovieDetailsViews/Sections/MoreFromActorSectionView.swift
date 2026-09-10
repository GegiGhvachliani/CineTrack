//
//  MoreFromActorSectionView.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import LibraryDomain

import DesignSystemComponents
import SharedCore

struct MoreFromActorSectionView: View {

    // MARK: - Properties

    let actorName: String
    let movies: [Movie]
    let isWatchlisted: (Movie) -> Bool
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        HorizontalScrollView(
            headerText: MovieDetailsStrings.Format.moreFrom(actorName: actorName),
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
