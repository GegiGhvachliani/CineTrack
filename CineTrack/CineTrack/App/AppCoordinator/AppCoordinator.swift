import UIKit
import SharedCore

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
        // დროებითი ცვლადი სიმულაციისთვის (თითქოს მომხმარებელი უკვე შესულია)
        let isUserLoggedIn = true
        
        if isUserLoggedIn {
            showMainFlow()
        } else {
            showAuthFlow()
        }
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
        // აქ სამომავლოდ ჩაიწერება Auth-ის (ავტორიზაციის) ჩართვის ლოგიკა
        print("აქ გამოჩნდება შესვლის ეკრანი")
//        
//        / 1. ფექიჯიდან (მაგალითად, AuthFactory-დან) ამოვიღებთ გამზადებულ კონტროლერს
//            // let loginViewController = AuthFactory().makeLoginViewController()
//            
//            // 2. ჩვენს უხილავ rootNavigationController-ს ვეტყვით, რომ ჩაანაცვლოს ეკრანები
//            // rootNavigationController.setViewControllers([loginViewController], animated: true)
//        }
    }
}
