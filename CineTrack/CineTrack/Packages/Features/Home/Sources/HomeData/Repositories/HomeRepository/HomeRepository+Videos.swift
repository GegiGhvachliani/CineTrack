//
//  HomeRepository+Videos.swift
//  Home
//
//  Created by Gegi Ghvachliani on 12/08/2026.
//


import Foundation
import HomeDomain
import SharedNetworking
import SharedCore
import TMDBData

extension HomeRepository {

    // MARK: - Videos

    public func fetchVideos(movieId: Int) async throws -> [MovieVideo] {

        let request = try requestBuilder.build(for: .movieVideos(movieID: movieId))

        let response: MovieVideosResponseDTO = try await apiClient.sendRequest(request)

        return videoMapper.map(response)
    }
}
