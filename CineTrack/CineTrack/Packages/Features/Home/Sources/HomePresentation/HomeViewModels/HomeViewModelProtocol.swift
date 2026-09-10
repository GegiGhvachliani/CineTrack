import Foundation
import LibraryDomain
import Observation
import HomeDomain
import SharedCore

@MainActor
public protocol HomeViewModelProtocol: AnyObject, Observable {

    // MARK: - State & Actions

    var onSearch: (() -> Void)? { get set }
    var onVideos: ((FeaturedItem) -> Void)? { get set }
    var onSeeAll: ((SeeAllContent) -> Void)? { get set }
    var onMovieDetails: ((Movie) -> Void)? { get set }
    var onActorDetails: ((Int) -> Void)? { get set }
    var onNewsDetails: ((News) -> Void)? { get set }
    var trendingMovies: [Movie] { get }
    var popularMovies: [Movie] { get }
    var fanFavouriteMovies: [Movie] { get }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }
    var top10Movies: [Movie] { get }
    var selectedFavouriteActor: Actor? { get }
    var selectedFavouriteActorMovies: [Movie] { get }
    var bornTodayActors: [Actor] { get }
    var mostPopularActors: [Actor] { get }
    var featuredItems: [FeaturedItem] { get }
    var movieVideos: [Int: [MovieVideo]] { get }
    var news: [News] { get }
    var recentlyViewedMovies: [RecentlyViewedMovie] { get }
    var recentlyViewedActors: [RecentlyViewedActor] { get }
    var recentlyViewedItems: [RecentlyViewedItem] { get }
    var watchlistedMovies: [Movie] { get }
    var favouritedActors: [Actor] { get }
    var isHomeLoading: Bool { get }
    var isTrendingLoading: Bool { get }
    var isPopularLoading: Bool { get }
    var isFanFavouriteLoading: Bool { get }
    var isNowPlayingLoading: Bool { get }
    var isUpcomingLoading: Bool { get }
    var isTop10Loading: Bool { get }
    var isBornTodayActorsLoading: Bool { get }
    var isMostPopularCelebritiesLoading: Bool { get }
    var isNewsLoading: Bool { get }
    var newsError: Error? { get }
    var isRecentlyViewedLoading: Bool { get }
    var hasMoreTrending: Bool { get }
    var hasMorePopular: Bool { get }
    var hasMoreFanFavourite: Bool { get }
    var hasMoreNowPlaying: Bool { get }
    var hasMoreUpcoming: Bool { get }
    var hasMoreBornTodayActors: Bool { get }
    var hasMoreMostPopularCelebrities: Bool { get }
    var hasMoreNews: Bool { get }
    var error: Error? { get }

    // MARK: - Methods

    func clearError()
    func loadNextBornTodayActorsPage() async
    func loadNextMostPopularCelebritiesPage() async
    func loadNextTrendingPage() async
    func loadNextPopularPage() async
    func loadNextFanFavouritePage() async
    func loadNextNowPlayingPage() async
    func loadNextUpcomingPage() async
    func loadTop10Movies() async
    func loadWatchlist() async
    func toggleWatchlist(for movie: Movie) async
    func loadNextNewsPage() async
    func refreshPersonalizedContent() async
    func loadFavourites() async
    func toggleFavourite(for actor: Actor) async
    func loadFavouriteActorMovies() async
    func didTapSearch()
    func didTapMovie(_ movie: Movie)
    func didTapActor(_ actor: Actor)
    func didTapVideos(_ item: FeaturedItem)
    func didTapSeeAll(_ section: HomeSection)
    func didTapNews(_ news: News)
    func loadVideos(
        for movie: Movie
    ) async
    func loadRecentlyViewed() async
    func clearRecentlyViewed() async
    func restoreVisibleSections() async
    func loadHome() async
}
