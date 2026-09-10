import UIKit
import SharedCore

@MainActor
public protocol NewsDetailsFactoryProtocol {

    func makeNewsDetailsCoordinator(
        news: News,
        navigationController: UINavigationController
    ) -> NewsDetailsCoordinatorProtocol

    func makeNewsDetailsViewController(
        news: News,
        coordinator: NewsDetailsCoordinatorProtocol
    ) -> UIViewController
}
