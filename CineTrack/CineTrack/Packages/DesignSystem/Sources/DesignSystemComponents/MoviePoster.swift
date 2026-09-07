import SwiftUI

public struct MoviePoster: View {
    private let isWatchlisted: Bool?
    private let photoURL: String?
    private let watchlistButtonSize: CGFloat
    private let watchlistButtonVerticalOffset: CGFloat?
    private let onMovieTap: () -> Void
    private let onWatchlistTap: (() -> Void)?

    public init(
        isWatchlisted: Bool,
        photoURL: String?,
        watchlistButtonSize: CGFloat = 30,
        watchlistButtonVerticalOffset: CGFloat? = nil,
        onMovieTap: @escaping () -> Void,
        onWatchlistTap: @escaping () -> Void
    ) {
        self.isWatchlisted = isWatchlisted
        self.photoURL = photoURL
        self.watchlistButtonSize = watchlistButtonSize
        self.watchlistButtonVerticalOffset = watchlistButtonVerticalOffset
        self.onMovieTap = onMovieTap
        self.onWatchlistTap = onWatchlistTap
    }

    public init(
        photoURL: URL?,
        onMovieTap: @escaping () -> Void
    ) {
        self.isWatchlisted = nil
        self.photoURL = photoURL?.absoluteString
        self.watchlistButtonSize = 30
        self.watchlistButtonVerticalOffset = nil
        self.onMovieTap = onMovieTap
        self.onWatchlistTap = nil
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            Button(action: onMovieTap) {
                PosterImageView(photoURL: photoURL)
            }
            .buttonStyle(.plain)

            if let isWatchlisted, let onWatchlistTap {
                WatchlistButton(
                    isAdded: isWatchlisted,
                    size: watchlistButtonSize,
                    verticalOffset: watchlistButtonVerticalOffset,
                    action: onWatchlistTap
                )
            }
        }
        .clipped()
    }
}
