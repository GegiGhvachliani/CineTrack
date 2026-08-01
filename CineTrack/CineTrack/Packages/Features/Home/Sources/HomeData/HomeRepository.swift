//
//  HomeRepository.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import HomeDomain
import SharedCore
import SharedNetworking
import TMDBData

public final class HomeRepository: HomeRepositoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let requestBuilder: TMDBRequestBuilder
    private let mapper: MovieMapper

    // MARK: - Initializer

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        mapper: MovieMapper = MovieMapper()
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(
            configuration: configuration
        )
        self.mapper = mapper
    }

    // MARK: - Public Methods

    public func fetchTrending(
        page: Int
    ) async throws -> MoviePage {
        try await fetchMovies(
            from: .trending(
                timeWindow: .week,
                page: page
            )
        )
    }

    public func fetchPopular(
        page: Int
    ) async throws -> MoviePage {
        try await fetchMovies(
            from: .popular(
                page: page
            )
        )
    }

    public func fetchTopRated(
        page: Int
    ) async throws -> MoviePage {
        try await fetchMovies(
            from: .topRated(
                page: page
            )
        )
    }

    public func fetchNowPlaying(
        page: Int
    ) async throws -> MoviePage {
        try await fetchMovies(
            from: .nowPlaying(
                page: page
            )
        )
    }

    public func fetchUpcoming(
        page: Int
    ) async throws -> MoviePage {
        try await fetchMovies(
            from: .upcoming(
                page: page
            )
        )
    }

    // MARK: - Private Methods

    private func fetchMovies(
        from endpoint: TMDBEndpoint
    ) async throws -> MoviePage {

        let request = requestBuilder.build(
            for: endpoint
        )

        let response: MovieListResponseDTO = try await apiClient.sendRequest(
            request
        )

        return MoviePage(
            movies: mapper.map(response),
            page: response.page,
            totalPages: response.totalPages
        )
    }
}
