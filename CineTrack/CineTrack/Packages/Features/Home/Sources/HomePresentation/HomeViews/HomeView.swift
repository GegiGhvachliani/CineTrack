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

    @ObservedObject private var viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // სატესტო ჰორიზონტალური სქროლი[cite: 2]
                MovieHorizontalScrollView(
                    headerText: "Trending Now",
                    movies: viewModel.trendingMovies.isEmpty ? sampleMovies : viewModel.trendingMovies, //[cite: 3, 4]
                    onSeeAllTap: {
                        print("See All tapped!")
                    },
                    cell: { movie, index in
                        MovieCell(
                            movie: movie,
                            cellHeight: 240, // შეგიძლია შეცვალო სასურველი ზომით
                            isWatchlisted: false, // სატესტოდ[cite: 1]
                            onMovieTap: {
                                print("Navigating to movie: \(movie.title)") //[cite: 1]
                            },
                            onWatchlistTap: {
                                print("Added/Removed from watchlist") //[cite: 1]
                            }
                        )
                    }
                )
                
            }
            .padding(.top, 20)
        }
        .task {
            // მონაცემების ჩატვირთვა View-ს გამოჩენისას
            await viewModel.loadHome()
        }
    }

    private var sampleMovies: [Movie] {
        [
            Movie(
                id: 3,
                title: "Loading...",
                overview: "",
                posterPath: "",
                backdropPath: nil,
                releaseDate: nil,
                voteAverage: 0.0,
                voteCount: 0
            )
        ] //
    }
}
