//
//  CompactMovieCell.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct CompactMovieCell: View {

    // MARK: - Properties

    let movie: Movie

    // MARK: - Body

    var body: some View {
        HStack(spacing: SpacingTokens.medium) {
            PosterImageView(photoURL: movie.posterPath)
                .frame(width: 46, height: 68)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: SpacingTokens.xSmall) {
                Text(movie.title)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(2)

                HStack(spacing: SpacingTokens.small) {
                    if let releaseDate = movie.releaseDate {
                        Text(String(releaseDate.prefix(4)))
                    }
                    Image(systemName: "star.fill")
                        .foregroundStyle(ColorTokens.Brand.primary)
                    Text(String(format: "%.1f", movie.voteAverage))
                }
                .font(TypographyTokens.footnote)
                .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}
