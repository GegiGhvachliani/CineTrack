//
//  ActorDetailsRepository.swift
//  ActorDetailsData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

import ActorDetailsDomain
import SharedNetworking
import SharedCore
import TMDBData
import NewsData

public final class ActorDetailsRepository: ActorDetailsRepositoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let requestBuilder: TMDBRequestBuilder
    private let newsRequestBuilder: NewsRequestBuilder

    private let actorDetailsMapper: ActorDetailsMapper
    private let actorCreditMapper: ActorCreditMapper
    private let actorExternalLinksMapper: ActorExternalLinksMapper
    private let newsMapper: NewsMapper

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        newsConfiguration: NewsConfiguration,
        actorDetailsMapper: ActorDetailsMapper = ActorDetailsMapper(),
        actorCreditMapper: ActorCreditMapper = ActorCreditMapper(),
        actorExternalLinksMapper: ActorExternalLinksMapper = ActorExternalLinksMapper(),
        newsMapper: NewsMapper = NewsMapper()
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(
            configuration: configuration
        )
        self.newsRequestBuilder = NewsRequestBuilder(configuration: newsConfiguration)
        self.actorDetailsMapper = actorDetailsMapper
        self.actorCreditMapper = actorCreditMapper
        self.actorExternalLinksMapper = actorExternalLinksMapper
        self.newsMapper = newsMapper
    }

    // MARK: - Actor Details

    public func fetchActorDetails(actorID: Int) async throws -> ActorDetails {

        let request = try requestBuilder.build(for: .personDetails(personID: actorID))

        let response: ActorDetailsDTO = try await apiClient.sendRequest(request)

        return actorDetailsMapper.map(response)
    }

    // MARK: - Credits

    public func fetchActorCredits(actorID: Int) async throws -> [ActorCredit] {

        let request = try requestBuilder.build(for: .personMovieCredits(personID: actorID))

        let response: ActorCreditsResponseDTO = try await apiClient.sendRequest(request)

        return (response.cast + response.crew)
            .map(actorCreditMapper.map)
            .sorted { ($0.releaseDate ?? "") > ($1.releaseDate ?? "") }
    }

    // MARK: - External Links

    public func fetchActorExternalLinks(actorID: Int) async throws -> ActorExternalLinks {

        let request = try requestBuilder.build(for: .personExternalIDs(personID: actorID))

        let response: ActorExternalIDsDTO = try await apiClient.sendRequest(request)

        return actorExternalLinksMapper.map(response)
    }

    public func fetchActorNews(actorName: String) async throws -> [News] {
        
        let request = try newsRequestBuilder.build(for: .person(name: actorName, page: 1, pageSize: 10))
        
        let response: NewsResponseDTO = try await apiClient.sendRequest(request)
        
        return response.articles.compactMap(newsMapper.map)
    }
}
