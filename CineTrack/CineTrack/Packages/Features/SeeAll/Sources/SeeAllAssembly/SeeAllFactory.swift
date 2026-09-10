//
//  SeeAllFactory.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SeeAllDomain
import SeeAllData
import SeeAllPresentation
import SeeAllPresentationAPI
import SharedCore

@MainActor
public struct SeeAllFactory: SeeAllFactoryProtocol {

    // MARK: - Initialization

    public init() {}

    public func makeSeeAllViewController(
        content: SeeAllContent,
        coordinator: SeeAllCoordinatorProtocol
    ) -> UIViewController {

        // MARK: - Repository & Use Case

        let repository: SeeAllRepositoryProtocol = SeeAllRepository(content: content)
        let fetchPageUseCase: FetchSeeAllPageUseCaseProtocol = FetchSeeAllPageUseCase(repository: repository)

        // MARK: - ViewModel

        let viewModel = SeeAllViewModel(
            title: content.title,
            payload: content.payload,
            fetchPageUseCase: fetchPageUseCase
        )
        viewModel.onMovieTap = { [weak coordinator] in coordinator?.showMovieDetails(movie: $0) }
        viewModel.onActorTap = { [weak coordinator] in coordinator?.showActorDetails(actor: $0) }
        viewModel.onNewsTap = { [weak coordinator] in coordinator?.showNewsDetails(news: $0) }
        viewModel.onClose = { [weak coordinator] in coordinator?.close() }

        // MARK: - View

        let view = SeeAllView(viewModel: viewModel)

        let viewController = UIHostingController(rootView: view)
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium(), .large()]
        viewController.sheetPresentationController?.prefersGrabberVisible = true
        return viewController
    }

    // MARK: - Coordinator

    public func makeSeeAllCoordinator(
        content: SeeAllContent,
        presentingController: UIViewController,
        router: SeeAllRoutingProtocol
    ) -> SeeAllCoordinatorProtocol {
        SeeAllCoordinator(
            content: content,
            presentingController: presentingController,
            factory: self,
            router: router
        )
    }
}
