//
//  SeeAllMovieSectionView.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct SeeAllMovieSectionView: View {

    // MARK: - Properties

    let movies: [Movie]
    let onTap: (Movie) -> Void
    let onLoadMore: (Int, Int) -> Void

    // MARK: - Body

    var body: some View {
        List(movies) { movie in
            Button {
                onTap(movie)
            } label: {
                CompactMovieCell(movie: movie)
            }
            .buttonStyle(.plain)
            .onAppear {
                loadMoreIfNeeded(index: movies.firstIndex(where: { $0.id == movie.id }) ?? 0, count: movies.count)
            }
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            .listRowBackground(ColorTokens.Background.secondary)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ColorTokens.Background.secondary)
        .overlay { SeeAllEmptyStateView(isEmpty: movies.isEmpty) }
    }

    // MARK: - Pagination

    private func loadMoreIfNeeded(index: Int, count: Int) {
        onLoadMore(index, count)
    }
}
