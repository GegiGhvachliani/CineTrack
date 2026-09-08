//
//  SearchResultsSectionView.swift
//  Search
//

import SwiftUI

import DesignSystemTokens
import DesignSystemComponents
import HomePresentation
import SearchDomain
import SharedCore

struct SearchResultsSectionView: View {

    let movies: [Movie]
    let actors: [Actor]
    let isLoading: Bool
    let isLoadingMore: Bool
    let hasMoreResults: Bool
    let errorMessage: String?
    let hasSearched: Bool
    let selectedMode: SearchMode

    let onLoadMore: () -> Void
    let onMovieTap: (Movie) -> Void
    let onActorTap: (Actor) -> Void

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
                        "No results",
                        systemImage: "film.stack",
                        description: Text("Try another search or adjust the filters.")
                    )
                    .frame(maxWidth: .infinity, minHeight: 360, alignment: .center)
                } else {
                    resultsGrid
                }
            } else {
                ContentUnavailableView(
                    "Start exploring",
                    systemImage: "magnifyingglass",
                    description: Text(selectedMode == .recent ? "Search for a movie or an actor." : "Choose filters, then see your results.")
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
                    isWatchlisted: false,
                    cellHeight: 216,
                    onMovieTap: { onMovieTap(movie) },
                    onWatchlistTap: {}
                )
                .onAppear {
                    loadMoreIfNeeded(for: movie.id, in: movies.map(\.id))
                }
            }

            ForEach(actors) { actor in
                MovieActorCell(
                    actor: actor,
                    cellHeight: 216,
                    isFavourited: false,
                    onActorTap: { onActorTap(actor) },
                    onFavouriteTap: {}
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

#Preview {
    SearchResultsSectionView(
        movies: SearchPreviewData.movies,
        actors: [],
        isLoading: false,
        isLoadingMore: false,
        hasMoreResults: true,
        errorMessage: nil,
        hasSearched: true,
        selectedMode: .recent,
        onLoadMore: {},
        onMovieTap: { _ in },
        onActorTap: { _ in }
    )
    .padding()
    .background(ColorTokens.Background.main)
}
