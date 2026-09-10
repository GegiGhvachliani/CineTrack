//
//  NewsDetailsFNewsy.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SharedCore
import NewsDetailsDomain
import NewsDetailsData
import NewsDetailsPresentation
import NewsDetailsPresentationAPI

@MainActor
public struct NewsDetailsFactory: NewsDetailsFactoryProtocol {

    // MARK: - Initialization

    public init() {}

    public func makeNewsDetailsViewController(news: News, coordinator: NewsDetailsCoordinatorProtocol)
        -> UIViewController {
        let repository: NewsDetailsRepositoryProtocol = NewsDetailsRepository(article: news)
        let useCase: FetchNewsDetailsUseCaseProtocol = FetchNewsDetailsUseCase(repository: repository)
        let viewModel = NewsDetailsViewModel(fetchNewsDetailsUseCase: useCase)
        viewModel.onOpenSource = { [weak coordinator] url in
            coordinator?.showSource(url: url)
        }

        let view = NewsDetailsView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }

    // MARK: - Coordinator

    public func makeNewsDetailsCoordinator(
        news: News,
        navigationController: UINavigationController
    ) -> NewsDetailsCoordinatorProtocol {
        NewsDetailsCoordinator(
            news: news,
            navigationController: navigationController,
            factory: self
        )
    }
}
