//
//  MovieCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 02/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemTokens

struct MovieCell: View {
        
    let movie: Movie
    let isWatchlisted: Bool
    let cellHeight: CGFloat
    
    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void
    
    var body: some View {
        Button(action: onMovieTap) {
            VStack(spacing: 0) {
                
                MoviePoster(
                    isWatchlisted: isWatchlisted,
                    photoURL: movie.posterPath,
                    onMovieTap: onMovieTap,
                    onWatchlistTap: onWatchlistTap
                )
                .frame(height: cellHeight * 0.8)
                
                footer
                    .frame(height: cellHeight * 0.2)
                
                Spacer()
            }
            .background(ColorTokens.Background.primary)
            .frame(width: cellHeight * (8.0 / 15.0), height: cellHeight)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 5,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 5
                )
            )
            .shadow(radius: 3, x: 1, y: 3)
        }
    }
    
    // MARK: - Footer
    
    private var footer: some View {
        VStack(spacing: 2) {
            rating
            
            movieInfo
        }
        .padding(.top, 5)
        .padding(.horizontal, 6)
    }
    
    // MARK: - Rating
    
    private var rating: some View {
        HStack(spacing: 4) {
            
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 14)
                .offset(y: -1)
                .foregroundStyle(ColorTokens.Brand.primary)
            
            Text(String(format: "%.1f", movie.voteAverage))
            .font(Font.system(size: 15, weight: .none, design: .rounded))
            .foregroundColor(ColorTokens.Text.main)

            Spacer()
        }
    }
    
    // MARK: - Movie Info
    
    private var movieInfo: some View {
        HStack(spacing: 4) {
            
            Text(movie.title)
                .font(Font.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(ColorTokens.Text.main)
                .layoutPriority(1)
                .lineLimit(1)
            
            if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
                
                Text(String(releaseDate.prefix(4)))
                .font(Font.system(size: 13, weight: .regular, design: .rounded))
                .foregroundColor(.gray)
                .layoutPriority(0)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            }
            
            Spacer(minLength: 0)
        }
    }
}



#Preview {
    let movie: Movie = Movie(id: 3, title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: "2004-07-04", voteAverage: 8.9, voteCount: 12)
    
    MovieCell(movie: movie, isWatchlisted: false,
 cellHeight: 240,onMovieTap: {}, onWatchlistTap: {})
}
