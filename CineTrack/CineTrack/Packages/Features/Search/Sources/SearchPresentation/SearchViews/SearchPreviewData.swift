//
//  SearchPreviewData.swift
//  Search
//

import Foundation

import HomeDomain
import SearchDomain
import SharedCore

enum SearchPreviewData {

    static let movies = [
        Movie(
            id: 27205,
            title: "Inception",
            overview: "A thief enters dreams to steal secrets.",
            posterPath: nil,
            backdropPath: nil,
            releaseDate: "2010-07-16",
            voteAverage: 8.4,
            voteCount: 36_000
        ),
        Movie(
            id: 157336,
            title: "Interstellar",
            overview: "Explorers travel through a wormhole in space.",
            posterPath: nil,
            backdropPath: nil,
            releaseDate: "2014-11-05",
            voteAverage: 8.5,
            voteCount: 35_000
        ),
        Movie(
            id: 155,
            title: "The Dark Knight",
            overview: "Batman faces the Joker.",
            posterPath: nil,
            backdropPath: nil,
            releaseDate: "2008-07-16",
            voteAverage: 8.5,
            voteCount: 33_000
        )
    ]

    @MainActor
    static func makeViewModel() -> SearchViewModel {
        let viewModel = SearchViewModel(
            searchMoviesUseCase: PreviewSearchMoviesUseCase(),
            searchActorsUseCase: PreviewSearchActorsUseCase(),
            discoverMoviesUseCase: PreviewDiscoverMoviesUseCase(),
            fetchWatchlistedMoviesUseCase: PreviewFetchWatchlistedMoviesUseCase(),
            addWatchlistedMovieUseCase: PreviewAddWatchlistedMovieUseCase(),
            removeWatchlistedMovieUseCase: PreviewRemoveWatchlistedMovieUseCase(),
            fetchFavouritedActorsUseCase: PreviewFetchFavouritedActorsUseCase(),
            addFavouritedActorUseCase: PreviewAddFavouritedActorUseCase(),
            removeFavouritedActorUseCase: PreviewRemoveFavouritedActorUseCase()
        )

        viewModel.movies = movies
        viewModel.hasSearched = true

        return viewModel
    }
}

private struct PreviewSearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    func execute(query: String, page: Int) async throws -> [Movie] {
        SearchPreviewData.movies
    }
}

private struct PreviewSearchActorsUseCase: SearchActorsUseCaseProtocol {
    func execute(query: String, page: Int) async throws -> [Actor] {
        []
    }
}

private struct PreviewDiscoverMoviesUseCase: DiscoverMoviesUseCaseProtocol {
    func execute(filters: SearchFilters, page: Int) async throws -> [Movie] {
        SearchPreviewData.movies
    }
}

private struct PreviewFetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol {
    func execute() async throws -> [Movie] { [] }
}

private struct PreviewAddWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol {
    func execute(movie: Movie) async throws {}
}

private struct PreviewRemoveWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol {
    func execute(movie: Movie) async throws {}
}

private struct PreviewFetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol {
    func execute() async throws -> [Actor] { [] }
}

private struct PreviewAddFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol {
    func execute(actor: Actor) async throws {}
}

private struct PreviewRemoveFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol {
    func execute(actor: Actor) async throws {}
}
