import Foundation
import LibraryDomain
import Observation
import MovieDetailsDomain
import SharedCore

@MainActor
public protocol MovieDetailsViewModelProtocol: AnyObject, Observable {

    // MARK: - State & Actions

    var movie: Movie { get }
    var movieDetails: MovieDetails? { get }
    var cast: [MovieCastMember] { get }
    var videos: [MovieVideo] { get }
    var images: [MovieImage] { get }
    var similarMovies: [Movie] { get }
    var selectedActor: MovieCastMember? { get }
    var selectedActorMovies: [Movie] { get }
    var news: [News] { get }
    var videosSectionFeaturedVideo: MovieVideo? { get }
    var videosSectionAdditionalVideos: [MovieVideo] { get }
    var watchlistedMovieIDs: Set<Int> { get }
    var pendingWatchlistIDs: Set<Int> { get }
    var isWatchlisted: Bool { get }
    var isWatchlistUpdating: Bool { get }
    var isLoading: Bool { get }
    var isCastLoading: Bool { get }
    var isVideosLoading: Bool { get }
    var isImagesLoading: Bool { get }
    var isSimilarMoviesLoading: Bool { get }
    var isRelatedActorLoading: Bool { get }
    var isNewsLoading: Bool { get }
    var error: Error? { get }
    var sectionErrors: [MovieDetailsSection: Error] { get }
    var onMovieDetails: ((Movie) -> Void)? { get set }
    var onActorDetails: ((Int) -> Void)? { get set }
    var onNewsDetails: ((News) -> Void)? { get set }
    var onShowSeeAll: ((SeeAllContent) -> Void)? { get set }
    var onShowVideos: ((VideoPlaylistContext) -> Void)? { get set }

    // MARK: - Methods

    func didTapMovie(_ movie: Movie)
    func didTapActor(_ actor: MovieCastMember)
    func didTapNews(_ news: News)
    func didTapVideo(_ video: MovieVideo)
    func didTapSeeAllCast()
    func didTapSeeAllSimilarMovies()
    func didTapSeeAllActorMovies()
    func didTapSeeAllImages()
    func didTapSeeAllNews()
    func isWatchlisted(_ movie: Movie) -> Bool
    func toggleWatchlist() async
    func toggleWatchlist(for movie: Movie) async
    func load() async
    func retry() async
}
