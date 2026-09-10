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

    let apiClient: APIClient
    let requestBuilder: TMDBRequestBuilder
    let newsRequestBuilder: NewsRequestBuilder

    let movieMapper: MovieMapper
    let videoMapper: MovieVideoMapper
    let personMapper: PersonMapper
    let newsMapper: NewsMapper

    // MARK: - Configuration

    let upcomingRegion = "US"
    let popularPeoplePagesPerRequest = 5

    // MARK: - Initialization

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
        self.requestBuilder = TMDBRequestBuilder(configuration: configuration)
        self.newsRequestBuilder = NewsRequestBuilder(configuration: newsConfiguration)
        self.movieMapper = movieMapper
        self.videoMapper = videoMapper
        self.personMapper = personMapper
        self.newsMapper = newsMapper
    }

    // MARK: - Shared Helpers

    static var todayString: String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.string(from: Date())
    }
}
