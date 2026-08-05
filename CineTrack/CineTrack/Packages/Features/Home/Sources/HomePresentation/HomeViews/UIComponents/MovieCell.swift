//
//  MovieCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 02/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemTokens

//struct MovieCell: View {
//    let movie: Movie
//
//    let cellHeight: CGFloat
//
//    @State private var addedInWatchlist: Bool = false
//
//
//    var body: some View {
//        VStack(spacing: 0) {
//            MoviePoster(photoURL: movie.posterPath, addedInWatchlist: $addedInWatchlist)
//                .frame(height: cellHeight * 0.80)
//
//            footer
//                .frame(height: cellHeight * 0.20)
//
//            Spacer()
//        }
//        .background(ColorTokens.Background.primary)
//        .frame(width: cellHeight * (8.0 / 15.0), height: cellHeight)
//        .clipShape(
//            UnevenRoundedRectangle(
//                topLeadingRadius: 5,
//                bottomLeadingRadius: 10,
//                bottomTrailingRadius: 10,
//                topTrailingRadius: 5
//            )
//        )
//        .shadow(radius: 3, x: 1, y: 3)
//    }
//
//    private var footer: some View {
//        VStack(spacing: 2) {
//
//            HStack(spacing: 4) {
//                Image(systemName: "star.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 14)
//                    .offset(y: -1)
//                    .foregroundStyle(ColorTokens.Brand.primary)
//
//
//                Text(String(format: "%.1f", movie.voteAverage))
//                    .font(Font.system(size: 15, weight: .none, design: .rounded))
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//            HStack(spacing: 4) {
//                Text(movie.title)
//                    .font(Font.system(size: 14, weight: .medium, design: .rounded))
//                    .lineLimit(1)
//                    .layoutPriority(1)
//
//                if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
//                    Text(String(releaseDate.prefix(4)))
//                        .font(Font.system(size: 13, weight: .regular, design: .rounded))
//                        .foregroundStyle(.secondary)
//                        .lineLimit(1)
//                        .layoutPriority(0)
//                }
//
//                Spacer(minLength: 0)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//        }
//        .padding(.top, 5)
//        .padding(.horizontal, 6)
//    }
//}

struct MovieCell: View {
    
    let movie: Movie
    let cellHeight: CGFloat
    
    let isWatchlisted: Bool
    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {

            MoviePoster(
                photoURL: movie.posterPath,
                isWatchlisted: isWatchlisted,
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
        .shadow(
            radius: 3,
            x: 1,
            y: 3
        )
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
            
            Text(String(format: "%.1f",movie.voteAverage))
            .font(Font.system(size: 15,weight: .none,design: .rounded))
            
            Spacer()
        }
    }
    
    // MARK: - Movie Info
    
    private var movieInfo: some View {
        HStack(spacing: 4) {
            
            Text(movie.title)
                .font(Font.system(size: 14, weight: .medium, design: .rounded))
                .layoutPriority(1)
                .lineLimit(1)
            
            if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
                
                Text(String(releaseDate.prefix(4)))
                .font(Font.system(size: 13, weight: .regular, design: .rounded))
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
    
    MovieCell(movie: movie, cellHeight: 240, isWatchlisted: false, onMovieTap: {}, onWatchlistTap: {})
}

