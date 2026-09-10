import Foundation
import Observation
import LibraryDomain
import SearchDomain
import SharedCore

@MainActor
public protocol SearchViewModelProtocol: AnyObject, Observable {

    // MARK: - State & Actions

    var onMovieDetails: ((Movie) -> Void)? { get set }
    var onActorDetails: ((Int) -> Void)? { get set }
    var selectedMode: SearchMode { get set }
    var selectedTarget: SearchTarget { get set }
    var searchQuery: String { get set }
    var advancedFilters: SearchFilters { get set }
    var movies: [Movie] { get }
    var actors: [Actor] { get }
    var isLoading: Bool { get }
    var isLoadingMore: Bool { get }
    var hasMoreResults: Bool { get }
    var errorMessage: String? { get }
    var hasSearched: Bool { get }
    var watchlistedMovieIDs: Set<Int> { get }
    var favouritedActorIDs: Set<Int> { get }

    // MARK: - Methods

    func searchAdvancedMovies() async
    func didTapMovie(_ movie: Movie)
    func didTapActor(_ actor: Actor)
    func resetAdvancedOptions()
    func loadPersonalization() async
    func toggleWatchlist(for movie: Movie) async
    func toggleFavourite(for actor: Actor) async
    func loadNextResultsPage() async
}
