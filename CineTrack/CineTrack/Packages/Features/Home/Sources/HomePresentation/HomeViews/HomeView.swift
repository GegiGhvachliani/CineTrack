// HomeView.swift
import SwiftUI
import HomeDomain
import SharedCore
import DesignSystemTokens

// მოვაშორეთ Generic-ი და ვიყენებთ პირდაპირ კლასს
public struct HomeView: View {

    @ObservedObject private var viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // მოდი დროებით if-ები მოვხსნათ, რომ ვნახოთ ცარიელ მასივს ხატავს თუ საერთოდ არ რენდერდება
                MovieHorisontalScrollView(
                    headerText: "Trending Now (\(viewModel.trendingMovies.count))",
                    movies: viewModel.trendingMovies.isEmpty ? sampleMovies : viewModel.trendingMovies
                )
                
                MovieHorisontalScrollView(
                    headerText: "Popular Movies (\(viewModel.popularMovies.count))",
                    movies: viewModel.popularMovies.isEmpty ? sampleMovies : viewModel.popularMovies
                )
            }
            .padding(.vertical)
        }
        .background(ColorTokens.Background.secondary)
        .task {
            print("🚀 HomeView .task triggered, calling loadHome()")
            await viewModel.loadHome()
            print("✅ loadHome() finished. Trending count: \(viewModel.trendingMovies.count)")
        }
    }
    
    // დამხმარე სემფლი, რომ ეკრანზე რამე გამოჩნდეს თუ მონაცემი ცარიელია
    private var sampleMovies: [Movie] {
        [Movie(title: "Loading...", overview: "", posterPath: "", backdropPath: nil, releaseDate: nil, voteAverage: 0.0, voteCount: 0)]
    }
}
