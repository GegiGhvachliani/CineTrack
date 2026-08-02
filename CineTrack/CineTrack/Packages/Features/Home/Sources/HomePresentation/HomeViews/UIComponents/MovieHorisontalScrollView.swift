//
//  MovieHorisontalScrollView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 02/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemTokens

struct MovieHorisontalScrollView: View {
    private var headerText: String = "Top 10 on IMDB this week"
    private var movies: [Movie] = [
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12)
        
        
    ]
    
    init(headerText: String, movies: [Movie]) {
        self.headerText = headerText
        self.movies = movies
    }
    
    var body: some View {
        VStack {
            header
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    Color.clear
                        .frame(width: 0, height: 0)
                    ForEach(movies) { movie in
                        MovieCell(movie: movie, cellHeight: 240)
                    }
                }
            }
            .scrollIndicators(.hidden, axes: .horizontal)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorTokens.Background.secondary)
    }
    
    private var header: some View {
        HStack {
            Capsule()
                .frame(width: 4, height: 30)
                .foregroundStyle(ColorTokens.Brand.primary)
            
            Text(headerText)
                .font(TypographyTokens.title3)
            
            Spacer()
            
            Button {
                print("See All Tapped 😘")
            } label: {
                Text("See All")
                    .font(TypographyTokens.body)
            }
        }
        .padding(.horizontal)
    }
}



#Preview {
    var movies: [Movie] = [
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12),
        Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12)
        
        
    ]

    MovieHorisontalScrollView(
       headerText: "Top 10 on IMDB this week",
        movies: movies)
        .frame(height: 320)
}
