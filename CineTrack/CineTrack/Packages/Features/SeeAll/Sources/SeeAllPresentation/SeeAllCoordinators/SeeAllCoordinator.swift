//
//  SeeAllCoordinator.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit

import SeeAllPresentationAPI
import SharedCore

public final class SeeAllCoordinator: NSObject, SeeAllCoordinatorProtocol, UIAdaptivePresentationControllerDelegate {

    // MARK: - Actions

    public var onFinish: (() -> Void)?
    public var childCoordinators: [Coordinator] = []

    // MARK: - Dependencies

    private let content: SeeAllContent
    private let factory: SeeAllFactoryProtocol
    private weak var presentingController: UIViewController?
    private weak var router: SeeAllRoutingProtocol?

    // MARK: - Initialization

    public init(
        content: SeeAllContent,
        presentingController: UIViewController,
        factory: SeeAllFactoryProtocol,
        router: SeeAllRoutingProtocol
    ) {
        self.content = content
        self.presentingController = presentingController
        self.factory = factory
        self.router = router
    }

    // MARK: - Navigation

    public func start() {
        let viewController = factory.makeSeeAllViewController(content: content, coordinator: self)
        viewController.presentationController?.delegate = self
        presentingController?.present(viewController, animated: true)
    }

    public func showMovieDetails(movie: Movie) {
        dismiss { [weak router] in router?.showMovieDetails(movie: movie) }
    }

    public func showActorDetails(actor: Actor) {
        dismiss { [weak router] in router?.showActorDetails(actorID: actor.id) }
    }

    public func showNewsDetails(news: News) {
        dismiss { [weak router] in router?.showNewsDetails(news: news) }
    }

    public func close() {
        dismiss {}
    }

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onFinish?()
    }

    // MARK: - Dismissal

    private func dismiss(completion: @escaping () -> Void) {
        presentingController?.dismiss(animated: true) { [weak self] in
            self?.onFinish?()
            completion()
        }
    }
}
