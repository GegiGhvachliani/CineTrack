import Foundation
import Observation

import SharedCore
import VideosListDomain

@Observable
@MainActor
public final class VideosListViewModel: VideosListViewModelProtocol {

    // MARK: - Content

    public let movie: Movie
    public let context: VideoPlaylistContext
    public internal(set) var selectedVideo: MovieVideo
    public internal(set) var playlist: [MovieVideo] = []
    public internal(set) var isLoading = false
    public internal(set) var errorMessage: String?

    // MARK: - Navigation

    public var onMovieDetails: ((VideoPlaylistContext) -> Void)?

    public var onClose: (() -> Void)?

    // MARK: - Dependencies

    internal let fetchPlaylistVideosUseCase: FetchPlaylistVideosUseCaseProtocol

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

    public var canSelectPreviousVideo: Bool {
        guard let index = selectedVideoIndex else { return false }
        return index > 0
    }

    public var canSelectNextVideo: Bool {
        guard let index = selectedVideoIndex else { return false }
        return index < playlist.count - 1
    }

    // MARK: - Private

    internal var selectedVideoIndex: Int? {
        playlist.firstIndex(where: { $0.id == selectedVideo.id })
    }

}
