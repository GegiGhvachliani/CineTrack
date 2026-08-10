//
//  HomeView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 02/08/2026.
//

import SwiftUI
import HomeDomain
import SharedCore
import DesignSystemTokens

public struct HomeView: View {

    // MARK: - ViewModel

    @State var viewModel: HomeViewModel

    // MARK: - Initialization

    public init(viewModel: HomeViewModel) {
        self._viewModel = State(
            initialValue: viewModel
        )
    }

    // MARK: - Body

    public var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                header

                bornTodaySection

                top10SectionSection

                fanFavouritesSection

                comingSoonToTheaters
                nowStreaming
                trendingNow

                newsSection
                mostPopularActorsSection
                recentlyViewed

                FollowCinetrackWithLinksView()
            }
        }
        .ignoresSafeArea(edges: .vertical)
        .padding(.top)
        .scrollIndicators(.hidden)
        .task {
            await viewModel.loadHome()
        }
        .padding(.bottom, 50)
    }

    // MARK: - Header

    var header: some View {

        VStack(spacing: 0) {

            if !viewModel.featuredItems.isEmpty {

                FeaturedHorizontalScrollView(
                    featuredItems: viewModel.featuredItems,
                    isWatchlisted: {
                        viewModel.watchlistedMovieIDs.contains($0)
                    },
                    onVideoTap: { item in
                        print(
                            "Navigate to videos for movie:",
                            item.movie.id
                        )
                    },
                    onMovieTap: { movie in
                        print(
                            "Navigate to movie:",
                            movie.id
                        )
                    },
                    onWatchlistTap: { movie in
                        viewModel.toggleWatchlist(for: movie)
                    }
                )
            }

            SearchButtonView {
                print("Navigate to Search")
            }
        }
        .background(
            ColorTokens.Background.primary
        )
    }
}
