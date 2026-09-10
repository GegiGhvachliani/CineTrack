import Foundation
import LibraryDomain
import Observation
import ActorDetailsDomain
import ActorMediaDomain
import ActorVideosDomain
import SharedCore

@MainActor
public protocol ActorDetailsViewModelProtocol: AnyObject, Observable {

    // MARK: - State & Actions

    var actor: ActorDetails? { get }
    var credits: [ActorCredit] { get }
    var mediaImages: [ActorMediaImage] { get }
    var actorVideos: [ActorVideo] { get }
    var isMediaLoading: Bool { get }
    var isVideosLoading: Bool { get }
    var hasMoreMedia: Bool { get }
    var externalLinks: ActorExternalLinks? { get }
    var news: [News] { get }
    var favouritedActorIDs: Set<Int> { get }
    var watchlistedMovieIDs: Set<Int> { get }
    var isLoading: Bool { get }
    var isCreditsLoading: Bool { get }
    var isExternalLinksLoading: Bool { get }
    var isNewsLoading: Bool { get }
    var error: Error? { get }
    var sectionErrors: [ActorDetailsSection: Error] { get }
    var actorID: Int { get }
    var onMovieDetails: ((Movie) -> Void)? { get set }
    var onNewsDetails: ((News) -> Void)? { get set }
    var onShowMiniBiography: ((ActorDetails) -> Void)? { get set }
    var onShowSeeAll: ((SeeAllContent) -> Void)? { get set }
    var onShowVideos: ((VideoPlaylistContext) -> Void)? { get set }
    var onOpenURL: ((URL) -> Void)? { get set }
    var featuredCredits: [ActorCredit] { get }
    var filmography: [ActorCredit] { get }
    var personalLinks: [ActorExternalLink] { get }
    var isFavourite: Bool { get }
    var isFavouriteUpdating: Bool { get }

    // MARK: - Methods

    func didTapCredit(
        _ credit: ActorCredit
    )
    func didTapNews(
        _ news: News
    )
    func didTapVideo(_ actorVideo: ActorVideo)
    func didTapMiniBiography()
    func didTapSeeAllFilmography()
    func didTapSeeAllImages()
    func didTapSeeAllNews()
    func didTapExternalURL(
        _ url: URL
    )
    func toggleFavourite() async
    func isWatchlisted(_ credit: ActorCredit) -> Bool
    func toggleWatchlist(for credit: ActorCredit) async
    func load() async
    func retry() async
    func loadNextMediaPage() async
}
