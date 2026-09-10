import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

public struct VideosListView<ViewModel: VideosListViewModelProtocol>: View {

    // MARK: - Properties

    @State
    private var viewModel: ViewModel
    @Environment(\.scenePhase)
    private var scenePhase

    @State
    private var isPlaying = false
    @State
    private var playbackError: String?

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

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
        VideosListPlayerSectionView(
            movie: viewModel.movie,
            video: viewModel.selectedVideo,
            isPlaying: $isPlaying,
            playbackError: $playbackError,
            onClose: viewModel.close
        )
    }

    // MARK: - Now playing

    private var nowPlayingSection: some View {
        VideosListNowPlayingSectionView(
            movie: viewModel.movie,
            video: viewModel.selectedVideo,
            onMovieDetails: viewModel.showMovieDetails
        )
    }

    // MARK: - Playlist

    private var playlistSection: some View {
        VideosListPlaylistSectionView(
            videos: viewModel.playlist,
            selectedVideoID: viewModel.selectedVideo.id,
            isLoading: viewModel.isLoading,
            errorMessage: viewModel.errorMessage,
            isPlaying: isPlaying,
            onSelect: viewModel.selectVideo
        )
    }

}
