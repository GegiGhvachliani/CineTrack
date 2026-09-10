//
//  Top10MovieCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import DesignSystemTokens
import DesignSystemComponents

struct Top10MovieCell: View {

    // MARK: - Properties

    let movie: Movie
    let isWatchlisted: Bool
    let cellHeight: CGFloat

    let ratingNumber: Int

    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: onMovieTap) {
            VStack(spacing: 0) {

                MoviePoster(
                    isWatchlisted: isWatchlisted,
                    photoURL: movie.posterPath,
                    onMovieTap: onMovieTap,
                    onWatchlistTap: onWatchlistTap
                )
                .frame(height: (cellHeight - 25) * 0.8)

                footer
                    .frame(height: ((cellHeight - 25) * 0.2) + 20)

                Spacer()
            }
            .background(ColorTokens.Background.primary)
            .frame(width: (cellHeight - 25) * (8.0 / 15.0), height: cellHeight)
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
        VStack(spacing: 3) {

            Text(String(ratingNumber))
                .font(TypographyTokens.title3)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 4) {

                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .offset(y: -1)
                    .foregroundStyle(ColorTokens.Brand.primary)

                Text(String(format: "%.1f", movie.voteAverage))
                    .font(Font.system(size: 15, weight: .none, design: .rounded))
                    .foregroundStyle(ColorTokens.Text.main)

                Spacer()
            }
        }
    }

    // MARK: - Movie Info

    private var movieInfo: some View {
        HStack(spacing: 4) {

            Text(movie.title)
                .font(Font.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(ColorTokens.Text.main)
                .layoutPriority(1)
                .lineLimit(1)

            if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {

                Text(String(releaseDate.prefix(4)))
                    .font(Font.system(size: 13, weight: .regular, design: .rounded))
                    .layoutPriority(0)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }

            Spacer(minLength: 0)
        }
    }
}
