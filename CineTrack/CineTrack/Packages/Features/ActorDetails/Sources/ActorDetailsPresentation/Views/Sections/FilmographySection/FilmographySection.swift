//
//  FilmographySection.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 07/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemTokens
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
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 5, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 5))
        .shadow(radius: 3, x: 1, y: 3)
    }

    private var cellHeight: CGFloat { ActorDetailsLayout.filmographyCellHeight }
    private var posterHeight: CGFloat { ActorDetailsLayout.filmographyPosterHeight }
    private var informationHeight: CGFloat { cellHeight - posterHeight }
    private var cellWidth: CGFloat { posterHeight * (2.0 / 3.0) }
}


#Preview {
    ScrollView {
        FilmographySection(
            credits: [
                ActorCredit(
                    id: 278,
                    creditID: "credit-1",
                    title: "The Shawshank Redemption",
                    overview: "A banker is sentenced to life in Shawshank State Penitentiary.",
                    posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
                    backdropPath: "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg",
                    posterURL: URL(
                        string: "https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg"
                    ),
                    backdropURL: nil,
                    releaseDate: "1994-09-23",
                    voteAverage: 8.7,
                    voteCount: 28000,
                    character: "Andy Dufresne",
                    department: "Acting",
                    job: nil,
                    order: 0
                ),
                ActorCredit(
                    id: 680,
                    creditID: "credit-2",
                    title: "Pulp Fiction",
                    overview: "Intertwining stories about Los Angeles crime.",
                    posterPath: "/dM2w364MScsjFf8pfMbaWUcWrR.jpg",
                    backdropPath: nil,
                    posterURL: URL(
                        string: "https://image.tmdb.org/t/p/w500/dM2w364MScsjFf8pfMbaWUcWrR.jpg"
                    ),
                    backdropURL: nil,
                    releaseDate: "1994-09-10",
                    voteAverage: 8.5,
                    voteCount: 27000,
                    character: "Vincent Vega",
                    department: "Acting",
                    job: nil,
                    order: 0
                )
            ],
            isWatchlisted: { _ in false },
            onMovieTap: { _ in },
            onWatchlistTap: { _ in },
            onSeeAllTap: {}
        )
    }
    .background(ColorTokens.Background.secondary)
}
