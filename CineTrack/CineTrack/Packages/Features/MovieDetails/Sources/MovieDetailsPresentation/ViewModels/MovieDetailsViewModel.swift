import Foundation
import Observation

import MovieDetailsDomain
import SharedCore

@MainActor
@Observable
public final class MovieDetailsViewModel {

    // MARK: - Movie

    public let movie: Movie
    public internal(set) var movieDetails: MovieDetails?
    public internal(set) var cast: [MovieCastMember] = []
    public internal(set) var videos: [MovieVideo] = []
    public internal(set) var images: [MovieImage] = []
    public internal(set) var similarMovies: [Movie] = []
    public internal(set) var selectedActor: MovieCastMember?
    public internal(set) var selectedActorMovies: [Movie] = []
    public internal(set) var news: [News] = []

    public var videosSectionFeaturedVideo: MovieVideo? {
        videos
            .filter { $0.type != .trailer }
            .sorted(by: videoSortOrder)
            .first
    }

    public var videosSectionAdditionalVideos: [MovieVideo] {
        guard let videosSectionFeaturedVideo else {
            return []
        }

        return videos.filter { $0.id != videosSectionFeaturedVideo.id }
    }

    // MARK: - Watchlist

    public internal(set) var watchlistedMovieIDs = Set<Int>()
    public internal(set) var pendingWatchlistIDs = Set<Int>()

    public var isWatchlisted: Bool {
        isWatchlisted(movie)
    }

    public var isWatchlistUpdating: Bool {
        pendingWatchlistIDs.contains(movie.id)
    }

    // MARK: - Loading state

    public internal(set) var isLoading = false
    public internal(set) var isCastLoading = false
    public internal(set) var isVideosLoading = false
    public internal(set) var isImagesLoading = false
    public internal(set) var isSimilarMoviesLoading = false
    public internal(set) var isRelatedActorLoading = false
    public internal(set) var isNewsLoading = false
    public internal(set) var error: Error?
    public internal(set) var sectionErrors: [MovieDetailsSection: Error] = [:]

    // MARK: - Actions

    public var onMovieDetails: ((Movie) -> Void)?
    public var onActorDetails: ((Int) -> Void)?
    public var onMovieViewed: ((Movie) -> Void)?
    public var onNewsDetails: ((News) -> Void)?
    public var onShowSeeAll: ((SeeAllContent) -> Void)?
    public var onShowVideos: ((VideoPlaylistContext) -> Void)?

    // MARK: - Dependencies

    let fetchMovieDetailsUseCase: FetchMovieDetailsUseCaseProtocol
    let fetchMovieCastUseCase: FetchMovieCastUseCaseProtocol
    let fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol
    let fetchMovieImagesUseCase: FetchMovieImagesUseCaseProtocol
    let fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCaseProtocol
    let fetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol
    let fetchMovieNewsUseCase: FetchMovieNewsUseCaseProtocol
    let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol
    let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol
    let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol

    var hasLoadedInitialContent = false

    // MARK: - Initialization

    public init(
        movie: Movie,
        fetchMovieDetailsUseCase: FetchMovieDetailsUseCaseProtocol,
        fetchMovieCastUseCase: FetchMovieCastUseCaseProtocol,
        fetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol,
        fetchMovieImagesUseCase: FetchMovieImagesUseCaseProtocol,
        fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCaseProtocol,
        fetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol,
        fetchMovieNewsUseCase: FetchMovieNewsUseCaseProtocol,
        fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol,
        addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol,
        removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol
    ) {
        self.movie = movie
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.fetchMovieCastUseCase = fetchMovieCastUseCase
        self.fetchMovieVideosUseCase = fetchMovieVideosUseCase
        self.fetchMovieImagesUseCase = fetchMovieImagesUseCase
        self.fetchSimilarMoviesUseCase = fetchSimilarMoviesUseCase
        self.fetchActorMoviesUseCase = fetchActorMoviesUseCase
        self.fetchMovieNewsUseCase = fetchMovieNewsUseCase
        self.fetchWatchlistedMoviesUseCase = fetchWatchlistedMoviesUseCase
        self.addWatchlistedMovieUseCase = addWatchlistedMovieUseCase
        self.removeWatchlistedMovieUseCase = removeWatchlistedMovieUseCase
    }

    // MARK: - Navigation

    public func didTapMovie(_ movie: Movie) {
        onMovieDetails?(movie)
    }

    public func didTapActor(_ actor: MovieCastMember) {
        onActorDetails?(actor.id)
    }

    public func didTapNews(_ news: News) {
        onNewsDetails?(news)
    }

    public func didTapVideo(_ video: MovieVideo) {
        onShowVideos?(
            VideoPlaylistContext(
                movie: movie,
                selectedVideo: video,
                source: .movieDetails
            )
        )
    }

    public func didTapSeeAllCast() {
        let actors = cast.map {
            Actor(
                id: $0.id,
                name: $0.name,
                birthday: nil,
                profilePath: $0.profileURL?.absoluteString ?? $0.profilePath
            )
        }
        onShowSeeAll?(SeeAllContent(title: "All Cast", payload: .actors(actors)))
    }

    public func didTapSeeAllSimilarMovies() {
        onShowSeeAll?(SeeAllContent(title: "More Like This", payload: .movies(similarMovies)))
    }

    public func didTapSeeAllActorMovies() {
        let title = "More From \(selectedActor?.name ?? "Actor")"
        onShowSeeAll?(SeeAllContent(title: title, payload: .movies(selectedActorMovies)))
    }

    public func didTapSeeAllImages() {
        let galleryImages = images.map {
            GalleryImage(id: $0.id, url: $0.url, aspectRatio: $0.aspectRatio)
        }
        onShowSeeAll?(SeeAllContent(title: "Images", payload: .images(galleryImages)))
    }

    public func didTapSeeAllNews() {
        onShowSeeAll?(SeeAllContent(title: "Related News", payload: .news(news)))
    }

    public func isWatchlisted(_ movie: Movie) -> Bool {
        watchlistedMovieIDs.contains(movie.id)
    }

    private func videoSortOrder(_ left: MovieVideo, _ right: MovieVideo) -> Bool {
        videoPriority(left) < videoPriority(right)
    }

    private func videoPriority(_ video: MovieVideo) -> Int {
        switch (video.official, video.type) {
        case (true, .trailer):
            return 0
        case (_, .trailer):
            return 1
        case (_, .teaser):
            return 2
        case (_, .featurette):
            return 3
        case (_, .behindTheScenes):
            return 4
        case (_, .clip):
            return 5
        case (_, .bloopers):
            return 6
        case (_, .unknown):
            return 7
        }
    }
}

public enum MovieDetailsSection: Hashable, Sendable {
    case cast
    case videos
    case images
    case similarMovies
    case relatedActor
    case news
    case watchlist
}
