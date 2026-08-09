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

    // MARK: - Born Today Configuration

    private let popularPeoplePagesPerRequest = 5

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
            from: .popular(page: page)
        )
    }

    public func fetchTopRated(
        page: Int
    ) async throws -> MoviePage {

        try await fetchMovies(
            from: .topRated(page: page)
        )
    }

    public func fetchNowPlaying(
        page: Int
    ) async throws -> MoviePage {

        try await fetchMovies(
            from: .nowPlaying(page: page)
        )
    }

    public func fetchUpcoming(
        page: Int
    ) async throws -> MoviePage {

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

    // MARK: - Born Today

    public func fetchBornTodayActors(
        page: Int
    ) async throws -> ActorPage {

        let firstPopularPage =
            ((page - 1) * popularPeoplePagesPerRequest) + 1

        let lastPopularPage =
            firstPopularPage + popularPeoplePagesPerRequest - 1

        let popularPeoplePages = try await fetchPopularPeoplePages(
            from: firstPopularPage,
            to: lastPopularPage
        )

        let people = popularPeoplePages
            .flatMap(\.results)

        let actors = await filterBornTodayActors(
            people
        )

        let hasNextPage = popularPeoplePages.contains {
            $0.page < $0.totalPages
        }

        return ActorPage(
            actors: actors,
            page: page,
            hasNextPage: hasNextPage
        )
    }

    // MARK: - Private Movies

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

    // MARK: - Popular People

    private func fetchPopularPeoplePages(
        from firstPage: Int,
        to lastPage: Int
    ) async throws -> [PopularPeopleResponseDTO] {

        try await withThrowingTaskGroup(
            of: PopularPeopleResponseDTO.self
        ) { group in

            for page in firstPage...lastPage {
                group.addTask { [apiClient, requestBuilder] in

                    let request = try requestBuilder.build(
                        for: .popularPeople(page: page)
                    )

                    return try await apiClient.sendRequest(
                        request
                    )
                }
            }

            var responses: [PopularPeopleResponseDTO] = []

            for try await response in group {
                responses.append(response)
            }

            return responses.sorted {
                $0.page < $1.page
            }
        }
    }

    // MARK: - Born Today Filtering

    private func filterBornTodayActors(
        _ people: [PersonDTO]
    ) async -> [Actor] {

        let today = Date()
        let calendar = Calendar.current

        return await withTaskGroup(
            of: Actor?.self
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

                        let birthdayComponents =
                            calendar.dateComponents(
                                [.month, .day],
                                from: birthday
                            )

                        let todayComponents =
                            calendar.dateComponents(
                                [.month, .day],
                                from: today
                            )

                        guard
                            birthdayComponents.month ==
                                todayComponents.month,
                            birthdayComponents.day ==
                                todayComponents.day
                        else {
                            return nil
                        }

                        return actor

                    } catch {
                        return nil
                    }
                }
            }

            var actors: [Actor] = []

            for await actor in group {
                if let actor {
                    actors.append(actor)
                }
            }

            return actors
        }
    }
}
