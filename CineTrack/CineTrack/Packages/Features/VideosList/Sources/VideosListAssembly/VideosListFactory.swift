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

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let configuration: TMDBConfiguration

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration
    ) {
        self.apiClient = apiClient
        self.configuration = configuration
    }

    public func makeVideosListViewController(
        context: VideoPlaylistContext,
        coordinator: VideosListCoordinatorProtocol
    ) -> UIViewController {
        let repository = VideosListRepository(
            apiClient: apiClient,
            configuration: configuration
        )
        let viewModel = VideosListViewModel(
            context: context,
            fetchPlaylistVideosUseCase: FetchPlaylistVideosUseCase(repository: repository)
        )
        viewModel.onMovieDetails = { [weak coordinator] context in
            coordinator?.showMovieDetails(context: context)
        }
        viewModel.onClose = { [weak coordinator] in
            coordinator?.close()
        }
        let view = VideosListView(viewModel: viewModel)

        return UIHostingController(rootView: view)
    }

    // MARK: - Coordinator

    public func makeVideosListCoordinator(
        context: VideoPlaylistContext,
        navigationController: UINavigationController,
        router: VideosListRoutingProtocol
    ) -> VideosListCoordinatorProtocol {
        VideosListCoordinator(
            context: context,
            navigationController: navigationController,
            factory: self,
            router: router
        )
    }
}
