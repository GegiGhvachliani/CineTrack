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
import NewsData

public final class HomeRepository: HomeRepositoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient

    private let requestBuilder: TMDBRequestBuilder
    private let newsRequestBuilder: NewsRequestBuilder

    private let movieMapper: MovieMapper
    private let videoMapper: MovieVideoMapper
    private let personMapper: PersonMapper
    private let newsMapper: NewsMapper

    // MARK: - Configuration

    private let upcomingRegion = "US"

    private let popularPeoplePagesPerRequest = 5

    // MARK: - Initializer

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        newsConfiguration: NewsConfiguration,
        movieMapper: MovieMapper = MovieMapper(),
        videoMapper: MovieVideoMapper = MovieVideoMapper(),
        personMapper: PersonMapper = PersonMapper(),
        newsMapper: NewsMapper = NewsMapper()
    ) {
        self.apiClient = apiClient

        self.requestBuilder =
            TMDBRequestBuilder(
                configuration: configuration
            )

        self.newsRequestBuilder =
            NewsRequestBuilder(
                configuration:
                    newsConfiguration
            )

        self.movieMapper = movieMapper
        self.videoMapper = videoMapper
        self.personMapper = personMapper
        self.newsMapper = newsMapper
    }

    // MARK: - Movies

    public func fetchTrending(
        page: Int
    ) async throws -> MoviePage {

        try await fetchMovies(
            from:
                .trending(
                    timeWindow: .week,
                    page: page
                )
        )
    }

    public func fetchPopular(
        page: Int
    ) async throws -> MoviePage {

        try await fetchMovies(
            from:
                .popular(
                    page: page
                )
        )
    }

    public func fetchTopRated(
        page: Int
    ) async throws -> MoviePage {

        try await fetchMovies(
            from:
                .topRated(
                    page: page
                )
        )
    }

    public func fetchFanFavourites(
        page: Int
    ) async throws -> MoviePage {

        try await fetchMovies(
            from:
                .discoverMovies(
                    page: page,
                    sortBy:
                        "vote_average.desc",
                    voteCountGreaterThanOrEqual:
                        1000
                )
        )
    }

    public func fetchNowPlaying(
        page: Int
    ) async throws -> MoviePage {

        try await fetchMovies(
            from:
                .nowPlaying(
                    page: page
                )
        )
    }

    // MARK: - Upcoming US Theatrical

    public func fetchUpcoming(
        page: Int
    ) async throws -> MoviePage {

        print(
            "🎬 US UPCOMING REQUEST"
        )

        print(
            "🇺🇸 Region:",
            upcomingRegion
        )

        print(
            "📄 Page:",
            page
        )

        let request =
            try requestBuilder.build(
                for:
                    .upcoming(
                        page: page,
                        region:
                            upcomingRegion
                    )
            )

        print(
            "🌐 URL:",
            request.url.absoluteString
        )

        let response:
            MovieListResponseDTO =
                try await apiClient.sendRequest(
                    request
                )

        print(
            "🎬 US UPCOMING RESPONSE"
        )

        print(
            "📄 Page:",
            response.page
        )

        print(
            "📄 Total pages:",
            response.totalPages
        )

        print(
            "🎞️ Movies:",
            response.results.count
        )

        for movie in response.results {

            print(
                "➡️",
                movie.id,
                "|",
                movie.title,
                "| release:",
                movie.releaseDate ?? "nil"
            )
        }

        let movies =
            movieMapper.map(
                response
            )

        print(
            "🎬 MAPPED MOVIES:",
            movies.count
        )

        return MoviePage(
            movies: movies,
            page: response.page,
            totalPages:
                response.totalPages
        )
    }

    // MARK: - Videos

    public func fetchVideos(
        movieId: Int
    ) async throws -> [MovieVideo] {

        let request =
            try requestBuilder.build(
                for:
                    .movieVideos(
                        movieID: movieId
                    )
            )

        let response:
            MovieVideosResponseDTO =
                try await apiClient.sendRequest(
                    request
                )

        return videoMapper.map(
            response
        )
    }

    // MARK: - Born Today

    public func fetchBornTodayActors(
        page: Int
    ) async throws -> ActorPage {

        let firstPopularPage =
            (
                (page - 1)
                * popularPeoplePagesPerRequest
            ) + 1

        let lastPopularPage =
            firstPopularPage
            + popularPeoplePagesPerRequest
            - 1

        let popularPeoplePages =
            try await fetchPopularPeoplePages(
                from: firstPopularPage,
                to: lastPopularPage
            )

        let people =
            popularPeoplePages
                .flatMap(\.results)

        let actors =
            await filterBornTodayActors(
                people
            )

        let hasNextPage =
            popularPeoplePages.contains {
                $0.page < $0.totalPages
            }

        return ActorPage(
            actors: actors,
            page: page,
            hasNextPage:
                hasNextPage
        )
    }

    // MARK: - Most Popular Actors

    public func fetchMostPopularActors(
        page: Int
    ) async throws -> ActorPage {

        let request =
            try requestBuilder.build(
                for:
                    .popularPeople(
                        page: page
                    )
            )

        let response:
            PopularPeopleResponseDTO =
                try await apiClient.sendRequest(
                    request
                )

        let actors =
            response.results.compactMap {
                personMapper.map($0)
            }

        return ActorPage(
            actors: actors,
            page: response.page,
            hasNextPage:
                response.page
                < response.totalPages
        )
    }

    // MARK: - News

    public func fetchNews(
        page: Int
    ) async throws -> NewsPage {

        let request =
            try newsRequestBuilder.build(
                for:
                    .entertainment(
                        page: page,
                        pageSize: 20
                    )
            )

        let response:
            NewsResponseDTO =
                try await apiClient.sendRequest(
                    request
                )

        let news =
            response.articles.compactMap {
                newsMapper.map($0)
            }

        return NewsPage(
            news: news,
            page: page,
            totalResults:
                response.totalResults
        )
    }

    // MARK: - Private Movies

    private func fetchMovies(
        from endpoint: TMDBEndpoint
    ) async throws -> MoviePage {

        let request =
            try requestBuilder.build(
                for: endpoint
            )

        let response:
            MovieListResponseDTO =
                try await apiClient.sendRequest(
                    request
                )

        return MoviePage(
            movies:
                movieMapper.map(
                    response
                ),
            page:
                response.page,
            totalPages:
                response.totalPages
        )
    }

    // MARK: - Popular People

    private func fetchPopularPeoplePages(
        from firstPage: Int,
        to lastPage: Int
    ) async throws
        -> [PopularPeopleResponseDTO] {

        try await withThrowingTaskGroup(
            of:
                PopularPeopleResponseDTO
                .self
        ) { group in

            for page in
                firstPage...lastPage {

                group.addTask {
                    [apiClient, requestBuilder] in

                    let request =
                        try requestBuilder.build(
                            for:
                                .popularPeople(
                                    page: page
                                )
                        )

                    return try await
                        apiClient.sendRequest(
                            request
                        )
                }
            }

            var responses:
                [PopularPeopleResponseDTO] = []

            for try await response
                in group {

                responses.append(
                    response
                )
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

        let calendar =
            Calendar.current

        return await withTaskGroup(
            of: Actor?.self
        ) { group in

            for person in people {

                group.addTask {
                    [
                        apiClient,
                        requestBuilder,
                        personMapper
                    ] in

                    do {

                        let request =
                            try requestBuilder.build(
                                for:
                                    .personDetails(
                                        personID:
                                            person.id
                                    )
                            )

                        let details:
                            PersonDTO =
                            try await
                                apiClient.sendRequest(
                                    request
                                )

                        let actor =
                            personMapper.map(
                                details
                            )

                        guard let birthday =
                            actor?.birthday
                        else {
                            return nil
                        }

                        let birthdayComponents =
                            calendar.dateComponents(
                                [
                                    .month,
                                    .day
                                ],
                                from: birthday
                            )

                        let todayComponents =
                            calendar.dateComponents(
                                [
                                    .month,
                                    .day
                                ],
                                from: today
                            )

                        guard
                            birthdayComponents.month
                                ==
                                todayComponents.month,
                            birthdayComponents.day
                                ==
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

            var actors:
                [Actor] = []

            for await actor
                in group {

                if let actor {

                    actors.append(
                        actor
                    )
                }
            }

            return actors
        }
    }
}
