import SwiftUI
import SharedCore
import DesignSystemTokens

public struct MovieCell: View {

    // MARK: - Properties

    private let movie: Movie
    private let isWatchlisted: Bool
    private let cellHeight: CGFloat
    private let onMovieTap: () -> Void
    private let onWatchlistTap: () -> Void

    // MARK: - Initialization

    public init(
        movie: Movie,
        isWatchlisted: Bool,
        cellHeight: CGFloat,
        onMovieTap: @escaping () -> Void,
        onWatchlistTap: @escaping () -> Void
    ) {
        self.movie = movie
        self.isWatchlisted = isWatchlisted
        self.cellHeight = cellHeight
        self.onMovieTap = onMovieTap
        self.onWatchlistTap = onWatchlistTap
    }

    // MARK: - Body

    public var body: some View {
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

    private var footer: some View {
        VStack(spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .foregroundStyle(ColorTokens.Brand.primary)

                Text(String(format: "%.1f", movie.voteAverage))
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(ColorTokens.Text.main)

                Spacer()
            }

            HStack(spacing: 4) {
                Text(movie.title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(1)

                if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
                    Text(String(releaseDate.prefix(4)))
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 0)
            }
        }
        .padding(.top, 5)
        .padding(.horizontal, 6)
    }
}
