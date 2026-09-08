//
//  SearchRepository.swift
//  Search
//

import Foundation

import SearchDomain
import SharedCore
import SharedNetworking
import TMDBData

public final class SearchRepository: SearchRepositoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let requestBuilder: TMDBRequestBuilder
    private let movieMapper: MovieMapper
    private let personMapper: PersonMapper

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        movieMapper: MovieMapper = MovieMapper(),
        personMapper: PersonMapper = PersonMapper()
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(configuration: configuration)
        self.movieMapper = movieMapper
        self.personMapper = personMapper
    }

    // MARK: - Text search

    public func searchMovies(query: String, page: Int) async throws -> [Movie] {
        let request = try requestBuilder.build(for: .searchMovies(query: query, page: page))
        let response: MovieListResponseDTO = try await apiClient.sendRequest(request)

        return movieMapper.map(response)
    }

    public func searchActors(query: String, page: Int) async throws -> [Actor] {
        let request = try requestBuilder.build(for: .searchPeople(query: query, page: page))
        let response: PopularPeopleResponseDTO = try await apiClient.sendRequest(request)

        return response.results.compactMap(personMapper.map)
    }

    // MARK: - Advanced search

    public func discoverMovies(filters: SearchFilters, page: Int) async throws -> [Movie] {
        let request = try requestBuilder.build(
            for: .advancedMovieSearch(
                page: page,
                minimumRating: filters.minimumRating,
                minimumVoteCount: filters.minimumVoteCount,
                genreIDs: filters.genreIDs,
                releaseYear: filters.releaseYear,
                minimumRuntime: filters.minimumRuntime,
                maximumRuntime: filters.maximumRuntime,
                region: filters.region,
                keywordIDs: []
            )
        )

        let response: MovieListResponseDTO = try await apiClient.sendRequest(request)

        return movieMapper.map(response)
    }

}
