//
//  NewsDetailsCoordinator.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit

import NewsDetailsPresentationAPI
import SharedCore

public final class NewsDetailsCoordinator: NewsDetailsCoordinatorProtocol {

    // MARK: - Children

    public var childCoordinators: [Coordinator] = []

    // MARK: - Dependencies

    private let news: News
    private let navigationController: UINavigationController
    private let factory: NewsDetailsFactoryProtocol

    // MARK: - Initialization

    public init(
        news: News,
        navigationController: UINavigationController,
        factory: NewsDetailsFactoryProtocol
    ) {
        self.news = news
        self.navigationController = navigationController
        self.factory = factory
    }

    // MARK: - Navigation

    public func start() {
        let viewController = factory.makeNewsDetailsViewController(news: news, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    public func showSource(url: URL) {
        UIApplication.shared.open(url)
    }
}
