import UIKit
import SharedCore
import OnboardingPresentationAPI
import AuthenticationPresentationAPI

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let rootNavigationController = UINavigationController()
    private let container: AppDIContainerProtocol
    
    init(window: UIWindow, container: AppDIContainerProtocol) {
        self.window = window
        self.container = container
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
    
    private func showMainFlow() {
        // ვქმნით ტაბბარის კოორდინატორს და ვატანთ ჩვენს root ნავიგაციას
        let tabBarCoordinator = MainTabBarCoordinator(
            navigationController: rootNavigationController,
            container: container
        )
        
        // ვინახავთ მას მასივში, რომ მეხსიერებამ არ წაშალოს
        childCoordinators.append(tabBarCoordinator)
        
        // ვრთავთ ტაბბარის ნაკადს
        tabBarCoordinator.start()
    }
    
    private func showAuthFlow() {
        let authCoordinator = container.authenticationFactory.makeAuthenticationCoordinator(navigationController: rootNavigationController)
        
        authCoordinator.onFinish = { [weak self] in
            guard let self = self else { return }
            self.childCoordinators.removeAll { $0 is AuthenticationCoordinatorProtocol }
            self.showAuthFlow()
        }
        
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
}
