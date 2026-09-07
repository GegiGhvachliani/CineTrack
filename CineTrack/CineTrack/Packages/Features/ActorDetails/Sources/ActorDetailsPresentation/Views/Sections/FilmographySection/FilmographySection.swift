//
//  FilmographySection.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 07/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemComponents

struct FilmographySection: View {
    let credits: [ActorCredit]
    let isWatchlisted: (ActorCredit) -> Bool
    let onMovieTap: (ActorCredit) -> Void
    let onWatchlistTap: (ActorCredit) -> Void
    let onSeeAllTap: () -> Void

    var body: some View {
        if !credits.isEmpty {
            HorizontalScrollView(
                headerText: "Filmography",
                seeAllTitle: "See All",
                items: credits,
                showsSeeAllButton: true,
                onSeeAllTap: onSeeAllTap
            ) { credit, _ in
                posterCell(for: credit)
            }
        }
    }

    private func posterCell(for credit: ActorCredit) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            MoviePoster(
                isWatchlisted: isWatchlisted(credit),
                photoURL: credit.posterURL?.absoluteString,
                watchlistButtonSize: 20,
                watchlistButtonVerticalOffset: 0,
                onMovieTap: { onMovieTap(credit) },
                onWatchlistTap: { onWatchlistTap(credit) }
            )
            .frame(width: 70, height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 2))

            VStack(alignment: .leading, spacing: 3) {
                Text(credit.title)
                    .font(Font.system(size: 10, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(2)

                if let role = credit.character ?? credit.job {
                    Text(role)
                        .font(Font.system(size: 9, weight: .light, design: .rounded))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                if let releaseDate = credit.releaseDate {
                    Text(String(releaseDate.prefix(4)))
                        .font(Font.system(size: 8, weight: .light, design: .rounded))
                        .foregroundStyle(.white)
                }
            }
        }
        .frame(width: 70, height: 165, alignment: .topLeading)
        .clipped()
    }
}
