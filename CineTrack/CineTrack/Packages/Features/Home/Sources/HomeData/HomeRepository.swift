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

    private let movieMapper: MovieMapper
    private let videoMapper: MovieVideoMapper
    private let personMapper: PersonMapper

    // MARK: - Initializer

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        movieMapper: MovieMapper = MovieMapper(),
        videoMapper: MovieVideoMapper = MovieVideoMapper(),
        personMapper: PersonMapper = PersonMapper()
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(
            configuration: configuration
        )

        self.movieMapper = movieMapper
        self.videoMapper = videoMapper
        self.personMapper = personMapper
    }

    // MARK: - Movies

    public func fetchTrending(page: Int) async throws -> MoviePage {
        try await fetchMovies(
            from: .trending(
                timeWindow: .week,
                page: page
            )
        )
    }

    public func fetchPopular(page: Int) async throws -> MoviePage {
        try await fetchMovies(
            from: .popular(page: page)
        )
    }

    public func fetchTopRated(page: Int) async throws -> MoviePage {
        try await fetchMovies(
            from: .topRated(page: page)
        )
    }

    public func fetchNowPlaying(page: Int) async throws -> MoviePage {
        try await fetchMovies(
            from: .nowPlaying(page: page)
        )
    }

    public func fetchUpcoming(page: Int) async throws -> MoviePage {
        try await fetchMovies(
            from: .upcoming(page: page)
        )
    }

    // MARK: - Videos

    public func fetchVideos(
        movieId: Int
    ) async throws -> [MovieVideo] {

        let request = try requestBuilder.build(
            for: .movieVideos(movieID: movieId)
        )

        let response: MovieVideosResponseDTO =
            try await apiClient.sendRequest(request)

        return videoMapper.map(response)
    }

    // MARK: - Born Today Actors

    public func fetchBornTodayActors(
        page: Int
    ) async throws -> ActorPage {

        let popularPeopleRequest = try requestBuilder.build(
            for: .popularPeople(page: page)
        )

        let popularPeopleResponse: PopularPeopleResponseDTO =
            try await apiClient.sendRequest(popularPeopleRequest)

        let actors = await fetchBornTodayActors(
            from: popularPeopleResponse.results
        )

        return ActorPage(
            actors: actors,
            page: popularPeopleResponse.page,
            totalPages: popularPeopleResponse.totalPages
        )
    }

    // MARK: - Private Movie Methods

    private func fetchMovies(
        from endpoint: TMDBEndpoint
    ) async throws -> MoviePage {

        let request = try requestBuilder.build(
            for: endpoint
        )

        let response: MovieListResponseDTO =
            try await apiClient.sendRequest(request)

        return MoviePage(
            movies: movieMapper.map(response),
            page: response.page,
            totalPages: response.totalPages
        )
    }

    // MARK: - Private Person Methods

    private func fetchBornTodayActors(
        from people: [PersonDTO]
    ) async -> [Actor] {

        let calendar = Calendar.current
        let today = Date()

        return await withTaskGroup(
            of: Actor?.self,
            returning: [Actor].self
        ) { group in

            for person in people {
                group.addTask { [apiClient, requestBuilder, personMapper] in

                    do {
                        let request = try requestBuilder.build(
                            for: .personDetails(
                                personID: person.id
                            )
                        )

                        let details: PersonDTO =
                            try await apiClient.sendRequest(request)

                        let actor = personMapper.map(details)

                        guard let birthday = actor.birthday else {
                            return nil
                        }

                        let birthdayComponents = calendar.dateComponents(
                            [.month, .day],
                            from: birthday
                        )

                        let todayComponents = calendar.dateComponents(
                            [.month, .day],
                            from: today
                        )

                        guard
                            birthdayComponents.month == todayComponents.month,
                            birthdayComponents.day == todayComponents.day
                        else {
                            return nil
                        }

                        return actor

                    } catch {
                        return nil
                    }
                }
            }

            var result: [Actor] = []

            for await actor in group {
                if let actor {
                    result.append(actor)
                }
            }

            return result
        }
    }
}
