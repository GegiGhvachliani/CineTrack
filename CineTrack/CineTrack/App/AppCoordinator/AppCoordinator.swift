import UIKit
import SharedCore
import OnboardingPresentationAPI
import AuthenticationPresentationAPI

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    // თავდაპირველად ვქმნი ერთ მნავარ ნავიგაციის კონრტოლერს
    private let rootNavigationController = UINavigationController()
    private let container: AppDIContainerProtocol
    
    init(window: UIWindow, container: AppDIContainerProtocol) {
        self.window = window
        self.container = container
        
        // შექმნილ კონტროლერს ვაყენებ root-ად
        self.window.rootViewController = rootNavigationController
    }
    
    func start() {
        
        let isOnboardingCompleted = container.onboardingFactory.isOnboardingCompleted()
        
        if isOnboardingCompleted {
            
            let isUserLoggedIn = container.authenticationFactory.isUserAuthenticated()
            
            if isUserLoggedIn {
                showMainFlow()
            } else {
                showAuthFlow()
            }
        } else {
            showOnboardingFlow()
        }
    }
    
    private func showOnboardingFlow() {
        let onboardingCoordinator = container.onboardingFactory.makeOnboardingCoordinator(navigationController: rootNavigationController)
        
        onboardingCoordinator.onFinish = { [weak self] in
            guard let self = self else { return }
            self.childCoordinators.removeAll { $0 is OnboardingCoordinatorProtocol }
            
            self.showAuthFlow()
        }
        
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func showAuthFlow() {
        let authCoordinator = container.authenticationFactory.makeAuthenticationCoordinator(navigationController: rootNavigationController)
        
        authCoordinator.onFinish = { [weak self] in
            guard let self = self else { return }
            self.childCoordinators.removeAll { $0 is AuthenticationCoordinatorProtocol }
            self.showMainFlow()
        }
        
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    private func showMainFlow() {
        let tabBarCoordinator = MainTabBarCoordinator(
            navigationController: rootNavigationController,
            container: container
        )
        tabBarCoordinator.onSignedOut = { [weak self] in
            guard let self else { return }
            self.childCoordinators.removeAll { $0 is MainTabBarCoordinator }
            self.rootNavigationController.dismiss(animated: false)
            self.rootNavigationController.setViewControllers([], animated: false)
            self.showAuthFlow()
        }
        
        childCoordinators.append(tabBarCoordinator)
        
        tabBarCoordinator.start()
    }
}
