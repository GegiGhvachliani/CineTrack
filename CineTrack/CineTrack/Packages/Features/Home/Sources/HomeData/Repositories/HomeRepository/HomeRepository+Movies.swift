//
//  HomeRepository+Movies.swift
//  Home
//
//  Created by Gegi Ghvachliani on 12/08/2026.
//


import Foundation
import HomeDomain
import SharedCore
import SharedNetworking
import TMDBData

extension HomeRepository {

    // MARK: - Movies

    public func fetchTrending(page: Int) async throws -> MoviePage {

        try await fetchMovies(from: .trending(timeWindow: .week, page: page))
        
    }

    public func fetchPopular(page: Int) async throws -> MoviePage {
        
        try await fetchMovies(from: .popular(page: page))
        
    }

    public func fetchTopRated(page: Int) async throws -> MoviePage {
        
        try await fetchMovies(from: .topRated(page: page))
        
    }

    public func fetchFanFavourites(page: Int) async throws -> MoviePage {
        
        try await fetchMovies(from: .discoverMovies(page: page,sortBy: "vote_average.desc",voteCountGreaterThanOrEqual: 1000))
        
    }

    public func fetchNowPlaying(page: Int) async throws -> MoviePage {
        
        try await fetchMovies(from: .nowPlaying(page: page))
        
    }

    public func fetchUpcoming(page: Int) async throws -> MoviePage {
        try await fetchMovies(
            from: .discoverUpcoming(
                page: page,
                region: upcomingRegion,
                releaseDateGTE: Self.todayString
            )
        )
    }

    // MARK: - Private

    private func fetchMovies(from endpoint: TMDBEndpoint) async throws -> MoviePage {

        let request = try requestBuilder.build(for: endpoint)

        let response: MovieListResponseDTO = try await apiClient.sendRequest(request)

        return MoviePage(movies: movieMapper.map(response), page: response.page, totalPages: response.totalPages)
        
    }
    
    public func fetchMovies(for actorID: Int) async throws -> [Movie] {
        let request = try requestBuilder.build(
            for: .personMovieCredits(personID: actorID)
        )

        let response: PersonMovieCreditsResponseDTO =
            try await apiClient.sendRequest(request)

        return response.cast
            .map(movieMapper.map)
            .filter { $0.posterPath != nil }
            .sorted {
                ($0.releaseDate ?? "") > ($1.releaseDate ?? "")
            }
    }
}
