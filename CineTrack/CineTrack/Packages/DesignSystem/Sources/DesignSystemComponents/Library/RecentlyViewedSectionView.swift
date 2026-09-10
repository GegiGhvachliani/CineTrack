//
//  RecentlyViewedSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import DesignSystemTokens

public struct RecentlyViewedSectionView: View {

    // MARK: - Properties

    let items: [RecentlyViewedItem]

    let watchlistedMovies: [Movie]
    let favouritedActors: [Actor]

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void

    let onActorTap: (Actor) -> Void
    let onFavouriteTap: (Actor) -> Void

    let onSeeAllTap: () -> Void
    let onClearHistory: () -> Void

    // MARK: - Initialization

    public init(
        items: [RecentlyViewedItem], watchlistedMovies: [Movie], favouritedActors: [Actor],
        onMovieTap: @escaping (Movie) -> Void, onWatchlistTap: @escaping (Movie) -> Void,
        onActorTap: @escaping (Actor) -> Void, onFavouriteTap: @escaping (Actor) -> Void,
        onSeeAllTap: @escaping () -> Void, onClearHistory: @escaping () -> Void
    ) {
        self.items = items
        self.watchlistedMovies = watchlistedMovies
        self.favouritedActors = favouritedActors
        self.onMovieTap = onMovieTap
        self.onWatchlistTap = onWatchlistTap
        self.onActorTap = onActorTap
        self.onFavouriteTap = onFavouriteTap
        self.onSeeAllTap = onSeeAllTap
        self.onClearHistory = onClearHistory
    }

    // MARK: - Body

    public var body: some View {

        if items.isEmpty {

            emptyState

        } else {
            VStack(spacing: 0) {
                HorizontalScrollView(
                    headerText: DesignSystemStrings.Section.recentlyViewed,
                    seeAllTitle: DesignSystemStrings.Action.seeAll,
                    items: items,
                    onSeeAllTap: onSeeAllTap
                ) { item, _ in
                    cell(for: item)
                }

                clearHistoryButton
            }
            .background(ColorTokens.Background.secondary)
        }
    }

    // MARK: - Cell

    @ViewBuilder
    private func cell(for item: RecentlyViewedItem) -> some View {

        switch item {

        case .movie(let recentlyViewedMovie):

            let movie = Movie(
                id: recentlyViewedMovie.id,
                title: recentlyViewedMovie.title,
                overview: "",
                posterPath: recentlyViewedMovie.posterPath,
                backdropPath: nil,
                releaseDate: recentlyViewedMovie.releaseDate,
                voteAverage: recentlyViewedMovie.voteAverage,
                voteCount: 0
            )

            MovieCell(
                movie: movie,
                isWatchlisted: watchlistedMovies.contains {
                    $0.id == movie.id
                },
                cellHeight: 240,
                onMovieTap: {
                    onMovieTap(movie)
                },
                onWatchlistTap: {
                    onWatchlistTap(movie)
                }
            )

        case .actor(let recentlyViewedActor):

            let actor = Actor(
                id: recentlyViewedActor.id,
                name: recentlyViewedActor.name,
                birthday: recentlyViewedActor.birthday,
                profilePath: recentlyViewedActor.profilePath
            )

            MovieActorCell(
                actor: actor,
                cellHeight: 240,
                isFavourited: favouritedActors.contains {
                    $0.id == actor.id
                },
                onActorTap: {
                    onActorTap(actor)
                },
                onFavouriteTap: {
                    onFavouriteTap(actor)
                }
            )
        }
    }

    // MARK: - Clear History

    private var clearHistoryButton: some View {

        HStack {

            Button(action: onClearHistory) {

                Text(DesignSystemStrings.Action.clear)
                    .font(TypographyTokens.bodySmall)
                    .fontWeight(.medium)
                    .foregroundStyle(ColorTokens.Button.textButton)
                    .padding(.leading, 15)
                    .padding(.bottom, 10)
                    .background(ColorTokens.Background.secondary)

            }

            Spacer()

        }
    }

    // MARK: - Empty State

    private var emptyState: some View {

        VStack(spacing: 20) {

            HStack(spacing: 8) {

                Capsule()
                    .frame(
                        width: 4,
                        height: 25
                    )
                    .foregroundStyle(
                        ColorTokens.Brand.primary
                    )

                Text(DesignSystemStrings.Section.recentlyViewed)
                    .font(
                        TypographyTokens.headline
                    )

                Spacer()
            }
            .padding(.horizontal)

            VStack(spacing: 10) {

                Text(DesignSystemStrings.EmptyState.recentlyViewedTitle)
                    .font(
                        TypographyTokens.bodySmall
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                    .padding(.horizontal, 40)

                Text(DesignSystemStrings.EmptyState.recentlyViewedSubtitle)
                    .font(TypographyTokens.caption)
                    .multilineTextAlignment(.center)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 15)
        .padding(.bottom, 15)
        .background(
            ColorTokens.Background.secondary
        )
    }
}
