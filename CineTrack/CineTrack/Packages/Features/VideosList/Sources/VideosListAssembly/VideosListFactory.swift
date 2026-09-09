//
//  VideosListFactory.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SharedCore
import SharedNetworking
import TMDBData
import VideosListData
import VideosListDomain
import VideosListPresentation
import VideosListPresentationAPI

@MainActor
public struct VideosListFactory: VideosListFactoryProtocol {

    public init() {}

    public func makeVideosListViewController(
        context: VideoPlaylistContext,
        onMovieDetails: @escaping (VideoPlaylistContext) -> Void
    ) -> UIViewController {
        let apiClient = URLSessionAPIClient()
        let configuration = TMDBConfiguration(
            baseURL: URL(string: "https://api.themoviedb.org")!,
            accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NWEyZmRkNjQyY2FmOTMzYTVjMzk5N2VkY2VjYTRjNSIsIm5iZiI6MTc2Mzk4OTQxNS42MDA5OTk4LCJzdWIiOiI2OTI0NTdhN2EwYzRiMWIxMzIxODc1ZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ZfESC0ZJHYqzbSE2xCYRjfOSwiacjs7sYl-_qvgDbc4"
        )
        let repository = VideosListRepository(
            apiClient: apiClient,
            configuration: configuration
        )
        let viewModel = VideosListViewModel(
            context: context,
            fetchPlaylistVideosUseCase: FetchPlaylistVideosUseCase(repository: repository)
        )
        viewModel.onMovieDetails = onMovieDetails
        let view = VideosListView(viewModel: viewModel)

        return UIHostingController(rootView: view)
    }
}
