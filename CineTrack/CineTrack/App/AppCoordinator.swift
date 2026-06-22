import UIKit
import SharedCore

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    // ეს არის მთელი აპლიკაციის უპირველესი, უხილავი ნავიგაციის კონტროლერი
    private let rootNavigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        // ფანჯრის მთავარ ეკრანად ვსვამთ ჩვენს უხილავ ნავიგაციას
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
        let tabBarCoordinator = MainTabBarCoordinator(navigationController: rootNavigationController)
        
        // ვინახავთ მას მასივში, რომ მეხსიერებამ არ წაშალოს
        childCoordinators.append(tabBarCoordinator)
        
        // ვრთავთ ტაბბარის ნაკადს
        tabBarCoordinator.start()
    }
    
    private func showAuthFlow() {
        // აქ სამომავლოდ ჩაიწერება Auth-ის (ავტორიზაციის) ჩართვის ლოგიკა
        print("აქ გამოჩნდება შესვლის ეკრანი")
    }
}
