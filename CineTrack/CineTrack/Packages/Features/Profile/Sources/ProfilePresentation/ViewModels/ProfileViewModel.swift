import Foundation
import HomeDomain
import Observation
import ProfileDomain
import SharedCore

@MainActor
@Observable
public final class ProfileViewModel {

    // MARK: - Content

    public internal(set) var account: ProfileAccount?
    public internal(set) var movies: [Movie] = []
    public internal(set) var actors: [Actor] = []
    public internal(set) var recentlyViewed: [RecentlyViewedItem] = []
    public internal(set) var isLoading = false
    public internal(set) var hasLoaded = false
    public internal(set) var isUpdatingPhoto = false
    public internal(set) var isSigningOut = false
    public var errorMessage: String?
    private var pendingItems = Set<String>()

    // MARK: - Navigation

    public var onMovieTap: ((Movie) -> Void)?
    public var onActorTap: ((Int) -> Void)?
    public var onSeeAll: ((SeeAllContent) -> Void)?
    public var onSignedOut: (() -> Void)?

    // MARK: - Dependencies

    private let fetchProfile: FetchProfileUseCase
    private let updatePhoto: UpdateProfilePhotoUseCase
    private let signOutUseCase: SignOutUseCase
    private let watchlist: WatchlistRepositoryProtocol
    private let favourites: FavouriteRepositoryProtocol
    private let history: RecentlyViewedRepositoryProtocol

    public init(
        accountRepository: ProfileRepositoryProtocol,
        watchlist: WatchlistRepositoryProtocol,
        favourites: FavouriteRepositoryProtocol,
        history: RecentlyViewedRepositoryProtocol
    ) {
        fetchProfile = FetchProfileUseCase(repository: accountRepository)
        updatePhoto = UpdateProfilePhotoUseCase(repository: accountRepository)
        signOutUseCase = SignOutUseCase(repository: accountRepository)
        self.watchlist = watchlist
        self.favourites = favourites
        self.history = history
    }

    // MARK: - Loading

    public func load() async {
        guard !isLoading, !isSigningOut else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            async let profile = fetchProfile.execute()
            async let savedMovies = FetchWatchlistedMoviesUseCase(repository: watchlist).execute()
            async let savedActors = FetchFavouritedActorsUseCase(repository: favourites).execute()
            async let recentMovies = FetchRecentlyViewedMoviesUseCase(repository: history).execute()
            async let recentActors = FetchRecentlyViewedActorsUseCase(repository: history).execute()
            let result = try await (profile, savedMovies, savedActors, recentMovies, recentActors)
            account = result.0
            movies = result.1
            actors = result.2
            recentlyViewed = (result.3.map(RecentlyViewedItem.movie) + result.4.map(RecentlyViewedItem.actor))
                .sorted { $0.viewedAt > $1.viewedAt }
            hasLoaded = true
        } catch is CancellationError {
            return
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Actions

    public func toggleWatchlist(_ movie: Movie) async {
        guard !isSigningOut else { return }
        let key = "movie-\(movie.id)"
        guard pendingItems.insert(key).inserted else { return }
        defer { pendingItems.remove(key) }
        do {
            if movies.contains(where: { $0.id == movie.id }) {
                try await RemoveWatchlistedMovieUseCase(repository: watchlist).execute(movie: movie)
                movies.removeAll { $0.id == movie.id }
            } else {
                try await AddWatchlistedMovieUseCase(repository: watchlist).execute(movie: movie)
                movies.insert(movie, at: 0)
            }
        } catch { errorMessage = error.localizedDescription }
    }

    public func toggleFavourite(_ actor: Actor) async {
        guard !isSigningOut else { return }
        let key = "actor-\(actor.id)"
        guard pendingItems.insert(key).inserted else { return }
        defer { pendingItems.remove(key) }
        do {
            if actors.contains(where: { $0.id == actor.id }) {
                try await RemoveFavouritedActorUseCase(repository: favourites).execute(actor: actor)
                actors.removeAll { $0.id == actor.id }
            } else {
                try await AddFavouritedActorUseCase(repository: favourites).execute(actor: actor)
                actors.insert(actor, at: 0)
            }
        } catch { errorMessage = error.localizedDescription }
    }

    public func clearHistory() async {
        guard !isSigningOut else { return }
        guard pendingItems.insert("history").inserted else { return }
        defer { pendingItems.remove("history") }
        do {
            try await ClearRecentlyViewedUseCase(repository: history).execute()
            recentlyViewed = []
        } catch { errorMessage = error.localizedDescription }
    }

    public func savePhoto(_ data: Data) async {
        guard !isUpdatingPhoto, !isSigningOut else { return }
        isUpdatingPhoto = true
        defer { isUpdatingPhoto = false }
        do {
            try await updatePhoto.execute(data: data)
            account?.photoData = data
        } catch { errorMessage = error.localizedDescription }
    }

    public func signOut() async {
        guard !isSigningOut, !isUpdatingPhoto, pendingItems.isEmpty else { return }
        isSigningOut = true
        defer { isSigningOut = false }
        do {
            try await signOutUseCase.execute()
            onSignedOut?()
        } catch { errorMessage = error.localizedDescription }
    }

    public func showHistory() {
        let items = recentlyViewed.map { item -> SeeAllLibraryItem in
            switch item {
            case .movie(let movie):
                return .movie(
                    Movie(
                        id: movie.id,
                        title: movie.title,
                        overview: "",
                        posterPath: movie.posterPath,
                        backdropPath: nil,
                        releaseDate: movie.releaseDate,
                        voteAverage: movie.voteAverage,
                        voteCount: 0
                    )
                )
            case .actor(let actor):
                return .actor(
                    Actor(
                        id: actor.id,
                        name: actor.name,
                        birthday: actor.birthday,
                        profilePath: actor.profilePath
                    )
                )
            }
        }
        onSeeAll?(SeeAllContent(title: "Recently Viewed", payload: .library(items)))
    }
}
