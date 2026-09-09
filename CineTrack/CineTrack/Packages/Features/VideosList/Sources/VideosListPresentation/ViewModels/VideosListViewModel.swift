import Foundation
import Observation

import SharedCore
import VideosListDomain

@MainActor
@Observable
public final class VideosListViewModel {

    // MARK: - Content

    public let movie: Movie
    public let context: VideoPlaylistContext
    public internal(set) var selectedVideo: MovieVideo
    public internal(set) var playlist: [MovieVideo] = []
    public internal(set) var isLoading = false
    public internal(set) var errorMessage: String?

    // MARK: - Navigation

    public var onMovieDetails: ((VideoPlaylistContext) -> Void)?

    // MARK: - Dependencies

    private let fetchPlaylistVideosUseCase: FetchPlaylistVideosUseCaseProtocol

    // MARK: - Initialization

    public init(
        context: VideoPlaylistContext,
        fetchPlaylistVideosUseCase: FetchPlaylistVideosUseCaseProtocol
    ) {
        self.context = context
        self.movie = context.movie
        self.selectedVideo = context.selectedVideo
        self.fetchPlaylistVideosUseCase = fetchPlaylistVideosUseCase
    }

    // MARK: - Actions

    public func loadPlaylist() async {
        guard playlist.isEmpty, !isLoading else {
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let videos = try await fetchPlaylistVideosUseCase.execute(movieID: movie.id)
            playlist = makePlaylist(from: videos)
        } catch is CancellationError {
            return
        } catch {
            errorMessage = "We couldn't load this playlist."
            playlist = [selectedVideo]
        }
    }

    public func selectVideo(_ video: MovieVideo) {
        selectedVideo = video
    }

    public func selectPreviousVideo() {
        guard let index = selectedVideoIndex, index > 0 else {
            return
        }

        selectedVideo = playlist[index - 1]
    }

    public func selectNextVideo() {
        guard let index = selectedVideoIndex, index < playlist.count - 1 else {
            return
        }

        selectedVideo = playlist[index + 1]
    }

    public func showMovieDetails() {
        onMovieDetails?(context)
    }

    public var canSelectPreviousVideo: Bool {
        guard let index = selectedVideoIndex else { return false }
        return index > 0
    }

    public var canSelectNextVideo: Bool {
        guard let index = selectedVideoIndex else { return false }
        return index < playlist.count - 1
    }

    // MARK: - Private

    private var selectedVideoIndex: Int? {
        playlist.firstIndex(where: { $0.id == selectedVideo.id })
    }

    private func makePlaylist(from videos: [MovieVideo]) -> [MovieVideo] {
        let includesSelectedVideo = videos.contains { $0.id == selectedVideo.id }
        return includesSelectedVideo ? videos : [selectedVideo] + videos
    }
}
