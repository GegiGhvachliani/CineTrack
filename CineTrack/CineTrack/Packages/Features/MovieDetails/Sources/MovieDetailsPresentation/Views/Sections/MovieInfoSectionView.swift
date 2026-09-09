import SwiftUI

import DesignSystemTokens
import MovieDetailsDomain

struct MovieInfoSectionView: View {
    let movie: MovieDetails
    let isWatchlisted: Bool
    let isWatchlistUpdating: Bool
    let onWatchlistTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            if let tagline = movie.tagline, !tagline.isEmpty {
                Text(tagline)
                    .font(TypographyTokens.bodySmall)
                    .italic()
                    .foregroundStyle(.secondary)
            }

            Text(movie.overview)
                .font(TypographyTokens.body)
                .foregroundStyle(ColorTokens.Text.main)

            HStack(spacing: 8) {
                if let releaseDate = movie.releaseDate {
                    Label(String(releaseDate.prefix(4)), systemImage: "calendar")
                }

                if let runtime = movie.runtime {
                    Label("\(runtime) min", systemImage: "clock")
                }
            }
            .font(TypographyTokens.footnote)
            .foregroundStyle(.secondary)

            if !movie.genres.isEmpty {
                Text(movie.genres.joined(separator: " · "))
                    .font(TypographyTokens.footnote)
                    .foregroundStyle(ColorTokens.Text.main)
            }

            addToWatchlistButton
        }
        .padding(16)
        .background(ColorTokens.Background.secondary)
    }

    private var addToWatchlistButton: some View {
        Button(action: onWatchlistTap) {
            HStack(spacing: 8) {
                Image(systemName: isWatchlisted ? "bookmark.fill" : "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)

                Text(isWatchlisted ? " Added to Watchlist" : " Add to Watchlist")
                    .font(.system(size: 15, weight: .regular, design: .rounded))

                Spacer()
            }
            .padding(.horizontal)
            .foregroundStyle(isWatchlisted ? .black : ColorTokens.Brand.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 35)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(isWatchlisted ? ColorTokens.Brand.primary : .clear)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(ColorTokens.Brand.primary, lineWidth: isWatchlisted ? 0 : 1)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(isWatchlistUpdating)
    }
}
