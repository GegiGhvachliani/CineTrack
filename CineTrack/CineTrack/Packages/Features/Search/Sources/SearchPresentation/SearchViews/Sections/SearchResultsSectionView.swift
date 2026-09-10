//
//  SearchResultsSectionView.swift
//  Search
//

import SwiftUI
import LibraryDomain

import DesignSystemTokens
import DesignSystemComponents
import SearchDomain
import SharedCore

struct SearchResultsSectionView: View {

    // MARK: - Properties

    let movies: [Movie]
    let actors: [Actor]
    let isLoading: Bool
    let isLoadingMore: Bool
    let hasMoreResults: Bool
    let errorMessage: String?
    let hasSearched: Bool
    let selectedMode: SearchMode
    let watchlistedMovieIDs: Set<Int>
    let favouritedActorIDs: Set<Int>

    let onLoadMore: () -> Void
    let onMovieTap: (Movie) -> Void
    let onActorTap: (Actor) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onFavouriteTap: (Actor) -> Void

    // MARK: - Body

    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .tint(ColorTokens.Brand.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 36)
            } else if let errorMessage {
                Text(errorMessage)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(ColorTokens.Status.error)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 36)
            } else if hasSearched {
                if movies.isEmpty, actors.isEmpty {
                    ContentUnavailableView(
                        SearchStrings.Content.noResults,
                        systemImage: "film.stack",
                        description: Text(SearchStrings.Content.tryAnotherSearchOrAdjustTheFilters)
                    )
                    .frame(maxWidth: .infinity, minHeight: 360, alignment: .center)
                } else {
                    resultsGrid
                }
            } else {
                ContentUnavailableView(
                    SearchStrings.Content.startExploring,
                    systemImage: "magnifyingglass",
                    description: Text(
                        selectedMode == .recent
                            ? SearchStrings.Content.searchForAMovieOrAnActor
                            : SearchStrings.Content.chooseFiltersThenSeeYourResults)
                )
                .frame(maxWidth: .infinity, minHeight: 420, alignment: .center)
            }
        }
    }

    private var resultsGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3),
            spacing: 10
        ) {
            ForEach(movies) { movie in
                MovieCell(
                    movie: movie,
                    isWatchlisted: watchlistedMovieIDs.contains(movie.id),
                    cellHeight: 216,
                    onMovieTap: { onMovieTap(movie) },
                    onWatchlistTap: { onWatchlistTap(movie) }
                )
                .onAppear {
                    loadMoreIfNeeded(for: movie.id, in: movies.map(\.id))
                }
            }

            ForEach(actors) { actor in
                MovieActorCell(
                    actor: actor,
                    cellHeight: 216,
                    isFavourited: favouritedActorIDs.contains(actor.id),
                    onActorTap: { onActorTap(actor) },
                    onFavouriteTap: { onFavouriteTap(actor) }
                )
                .onAppear {
                    loadMoreIfNeeded(for: actor.id, in: actors.map(\.id))
                }
            }

            if isLoadingMore {
                ProgressView()
                    .tint(ColorTokens.Brand.primary)
                    .gridCellColumns(3)
                    .padding(.vertical, 8)
            }
        }
        .padding(.horizontal, 4)
    }

    private func loadMoreIfNeeded(for id: Int, in identifiers: [Int]) {
        guard hasMoreResults, identifiers.last == id else { return }
        onLoadMore()
    }
}
