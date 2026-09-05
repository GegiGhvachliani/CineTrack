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

public final class ActorDetailsRepository: ActorDetailsRepositoryProtocol {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let requestBuilder: TMDBRequestBuilder

    private let actorDetailsMapper: ActorDetailsMapper
    private let actorCreditMapper: ActorCreditMapper
    private let actorImageMapper: ActorImageMapper
    private let actorExternalLinksMapper: ActorExternalLinksMapper

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        actorDetailsMapper: ActorDetailsMapper = ActorDetailsMapper(),
        actorCreditMapper: ActorCreditMapper = ActorCreditMapper(),
        actorImageMapper: ActorImageMapper = ActorImageMapper(),
        actorExternalLinksMapper: ActorExternalLinksMapper = ActorExternalLinksMapper()
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(
            configuration: configuration
        )
        self.actorDetailsMapper = actorDetailsMapper
        self.actorCreditMapper = actorCreditMapper
        self.actorImageMapper = actorImageMapper
        self.actorExternalLinksMapper = actorExternalLinksMapper
    }

    // MARK: - Actor Details

    public func fetchActorDetails(
        actorID: Int
    ) async throws -> ActorDetails {

        let request = try requestBuilder.build(
            for: .personDetails(personID: actorID)
        )

        let response: ActorDetailsDTO =
            try await apiClient.sendRequest(request)

        return actorDetailsMapper.map(response)
    }

    // MARK: - Credits

    public func fetchActorCredits(
        actorID: Int
    ) async throws -> [ActorCredit] {

        let request = try requestBuilder.build(
            for: .personMovieCredits(personID: actorID)
        )

        let response: ActorCreditsResponseDTO =
            try await apiClient.sendRequest(request)

        return response.cast.map(actorCreditMapper.map)
    }

    // MARK: - Images

    public func fetchActorImages(
        actorID: Int
    ) async throws -> [ActorImage] {

        let request = try requestBuilder.build(
            for: .personImages(personID: actorID)
        )

        let response: ActorImagesResponseDTO =
            try await apiClient.sendRequest(request)

        return response.profiles.map(actorImageMapper.map)
    }

    // MARK: - External Links

    public func fetchActorExternalLinks(
        actorID: Int
    ) async throws -> ActorExternalLinks {

        let request = try requestBuilder.build(
            for: .personExternalIDs(personID: actorID)
        )

        let response: ActorExternalIDsDTO =
            try await apiClient.sendRequest(request)

        return actorExternalLinksMapper.map(response)
    }
}
