import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

public struct VideosListView: View {

    @State private var viewModel: VideosListViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase

    @State private var isPlaying = false
    @State private var playbackError: String?

    public init(viewModel: VideosListViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    playerSection
                    nowPlayingSection
                    playlistSection
                }
                .padding(.bottom, 28)
            }
            .scrollIndicators(.hidden)
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await viewModel.loadPlaylist()
        }
        .onChange(of: viewModel.selectedVideo) {
            isPlaying = false
            playbackError = nil
        }
        .onDisappear { isPlaying = false }
        .onChange(of: scenePhase) {
            if scenePhase != .active { isPlaying = false }
        }
    }

    // MARK: - Player

    private var playerSection: some View {
        VStack(spacing: 0) {
            playerHeader
                .padding(16)

            EmbeddedVideoPlayer(
                video: viewModel.selectedVideo,
                isPlaying: $isPlaying,
                playbackError: $playbackError
            )
            .id(viewModel.selectedVideo.id)
            .aspectRatio(16 / 9, contentMode: .fit)
            .frame(minHeight: 200)

            if let playbackError {
                VStack(spacing: 10) {
                    Text(playbackError)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.7))
                    if let url = URL(string: "https://www.youtube.com/watch?v=\(viewModel.selectedVideo.key)") {
                        Link("Watch on YouTube", destination: url)
                            .foregroundStyle(ColorTokens.Brand.primary)
                    }
                }
                .padding(16)
            }

        }
        .background(ColorTokens.Background.primary)
    }

    private var playerHeader: some View {
        HStack(spacing: 14) {
            Button(action: dismiss.callAsFunction) {
                Image(systemName: "xmark")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color.white)
                    .frame(width: 32, height: 32)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.movie.title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text(viewModel.selectedVideo.type.rawValue)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()

        }
    }

    // MARK: - Now playing

    private var nowPlayingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("NOW PLAYING")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Button(action: viewModel.showMovieDetails) {
                HStack(spacing: 12) {
                    PosterImageView(photoURL: viewModel.movie.posterPath)
                        .frame(width: 58, height: 82)
                        .clipShape(RoundedRectangle(cornerRadius: 7))

                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.selectedVideo.name)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                            .lineLimit(1)

                        Text(viewModel.movie.overview)
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(.white.opacity(0.62))
                            .lineLimit(2)

                        Text(viewModel.movie.title)
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

    // MARK: - Playlist

    private var playlistSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("PLAYLIST")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            if viewModel.isLoading {
                ProgressView()
                    .tint(ColorTokens.Brand.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(.white.opacity(0.62))
                }

                ForEach(viewModel.playlist) { video in
                    PlaylistVideoCell(
                        video: video,
                        isSelected: video.id == viewModel.selectedVideo.id,
                        isPlaying: video.id == viewModel.selectedVideo.id && isPlaying
                    ) {
                        viewModel.selectVideo(video)
                    }
                }
            }
        }
        .padding(16)
        .background(ColorTokens.Background.secondary)
    }

}

private struct PlaylistVideoCell: View {
    let video: MovieVideo
    let isSelected: Bool
    let isPlaying: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    AsyncImage(url: thumbnailURL) { phase in
                        if case .success(let image) = phase {
                            image.resizable().scaledToFill()
                        } else {
                            Rectangle().fill(ColorTokens.Background.primary)
                        }
                    }

                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(.white)
                        .shadow(radius: 3)
                }
                .frame(width: 146, height: 88)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 5) {
                    Text(video.name)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)

                    Text(video.type.rawValue)
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.white.opacity(0.62))
                }

                Spacer(minLength: 0)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isSelected ? ColorTokens.Brand.primary.opacity(0.18) : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var thumbnailURL: URL? {
        guard video.site == .youtube else { return nil }
        return URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
    }
}
