//
//  VideosListRepository.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore
import SharedNetworking
import TMDBData
import VideosListDomain

public final class VideosListRepository: VideosListRepositoryProtocol, @unchecked Sendable {
    private let apiClient: APIClient
    private let requestBuilder: TMDBRequestBuilder
    private let videoMapper: MovieVideoMapper

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        videoMapper: MovieVideoMapper = MovieVideoMapper()
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(configuration: configuration)
        self.videoMapper = videoMapper
    }

    public func fetchVideos(movieID: Int) async throws -> [MovieVideo] {
        let request = try requestBuilder.build(for: .movieVideos(movieID: movieID))
        let response: MovieVideosResponseDTO = try await apiClient.sendRequest(request)
        return videoMapper.map(response)
    }
}
