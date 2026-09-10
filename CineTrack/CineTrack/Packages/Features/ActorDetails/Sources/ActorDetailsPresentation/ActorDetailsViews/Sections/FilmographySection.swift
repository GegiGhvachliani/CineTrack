//
//  FilmographySection.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 07/09/2026.
//

import SwiftUI
import LibraryDomain
import ActorDetailsDomain
import DesignSystemTokens
import DesignSystemComponents

struct FilmographySection: View {

    // MARK: - Properties

    let credits: [ActorCredit]
    let isWatchlisted: (ActorCredit) -> Bool
    let onMovieTap: (ActorCredit) -> Void
    let onWatchlistTap: (ActorCredit) -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        if !credits.isEmpty {
            HorizontalScrollView(
                headerText: ActorDetailsStrings.Content.filmography,
                seeAllTitle: ActorDetailsStrings.Content.seeAll,
                items: credits,
                showsSeeAllButton: true,
                onSeeAllTap: onSeeAllTap
            ) { credit, _ in
                posterCell(for: credit)
            }
        }
    }

    private func posterCell(for credit: ActorCredit) -> some View {
        VStack(spacing: 0) {
            MoviePoster(
                isWatchlisted: isWatchlisted(credit),
                photoURL: credit.posterURL?.absoluteString,
                watchlistButtonSize: 26,
                watchlistButtonVerticalOffset: -5,
                onMovieTap: { onMovieTap(credit) },
                onWatchlistTap: { onWatchlistTap(credit) }
            )
            .frame(width: cellWidth, height: posterHeight)

            VStack(alignment: .leading, spacing: 3) {
                Text(credit.title)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(1)

                if let role = credit.character ?? credit.job {
                    Text(role)
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                if let releaseDate = credit.releaseDate {
                    Text(String(releaseDate.prefix(4)))
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 6)
            .padding(.top, 6)
            .frame(height: informationHeight)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(width: cellWidth, height: cellHeight)
        .background(ColorTokens.Background.primary)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 5, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 5)
        )
        .shadow(radius: 3, x: 1, y: 3)
    }

    private var cellHeight: CGFloat { ActorDetailsLayout.filmographyCellHeight }
    private var posterHeight: CGFloat { ActorDetailsLayout.filmographyPosterHeight }
    private var informationHeight: CGFloat { cellHeight - posterHeight }
    private var cellWidth: CGFloat { posterHeight * (2.0 / 3.0) }
}
