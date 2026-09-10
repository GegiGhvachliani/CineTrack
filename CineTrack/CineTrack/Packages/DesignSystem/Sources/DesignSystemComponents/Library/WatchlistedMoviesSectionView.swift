//
//  WatchlistedMoviesSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore

public struct WatchlistedMoviesSectionView: View {

    // MARK: - Properties

    private let title: String

    let movies: [Movie]
    let watchlistedMovies: [Movie]

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void

    // MARK: - Initialization

    public init(
        title: String = "From your Watchlist",
        movies: [Movie],
        watchlistedMovies: [Movie],
        onMovieTap: @escaping (Movie) -> Void,
        onWatchlistTap: @escaping (Movie) -> Void,
        onSeeAllTap: @escaping () -> Void,
        onLoadMore: @escaping () -> Void
    ) {
        self.title = title
        self.movies = movies
        self.watchlistedMovies = watchlistedMovies
        self.onMovieTap = onMovieTap
        self.onWatchlistTap = onWatchlistTap
        self.onSeeAllTap = onSeeAllTap
        self.onLoadMore = onLoadMore
    }

    // MARK: - Body

    public var body: some View {

        HorizontalScrollView(
            headerText: title,
            seeAllTitle: DesignSystemStrings.Action.seeAll,
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
