import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct VideosListNowPlayingSectionView: View {

    // MARK: - Properties

    let movie: Movie
    let video: MovieVideo
    let onMovieDetails: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(VideosListStrings.Content.nowPlaying)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Button(action: onMovieDetails) {
                HStack(spacing: 12) {
                    PosterImageView(photoURL: movie.posterPath)
                        .frame(width: 58, height: 82)
                        .clipShape(RoundedRectangle(cornerRadius: 7))

                    VStack(alignment: .leading, spacing: 5) {
                        Text(video.name)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                            .lineLimit(1)

                        Text(movie.overview)
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(.white.opacity(0.62))
                            .lineLimit(2)

                        Text(movie.title)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.9))
                    }

                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(ColorTokens.Background.primary)
    }
}
