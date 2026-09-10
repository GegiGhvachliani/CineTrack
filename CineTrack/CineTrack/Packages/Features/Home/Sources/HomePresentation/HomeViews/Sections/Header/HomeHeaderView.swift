//
//  HomeHeaderView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import LibraryDomain
import HomeDomain
import SharedCore
import DesignSystemTokens

struct HomeHeaderView: View {

    // MARK: - Properties

    let featuredItems: [FeaturedItem]
    let watchlistedMovies: [Movie]

    let onVideoTap: (FeaturedItem) -> Void
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSearchTap: () -> Void

    // MARK: - Body

    var body: some View {

        VStack(spacing: 0) {

            featuredSection

            searchButton
        }
        .background(ColorTokens.Background.primary)
    }

    // MARK: - Featured Section

    @ViewBuilder
    private var featuredSection: some View {

        if !featuredItems.isEmpty {

            FeaturedHorizontalScrollView(
                featuredItems: featuredItems,
                isWatchlisted: { movieID in
                    watchlistedMovies.contains {
                        $0.id == movieID
                    }
                },
                onVideoTap: onVideoTap,
                onMovieTap: onMovieTap,
                onWatchlistTap: onWatchlistTap
            )
        }
    }

    // MARK: - Search Button

    private var searchButton: some View {

        Button(action: onSearchTap) {

            HStack(spacing: 5) {

                Image(systemName: "magnifyingglass")
                    .foregroundStyle(ColorTokens.Text.secondary)
                    .frame(width: 40)

                Text(HomeStrings.Section.search)
                    .foregroundStyle(ColorTokens.Text.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .background(ColorTokens.Background.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(ColorTokens.Background.primary)
        .accessibilityLabel(HomeStrings.Content.searchAction)
    }
}
