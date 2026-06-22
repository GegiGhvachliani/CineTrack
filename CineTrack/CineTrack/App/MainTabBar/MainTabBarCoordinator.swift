import UIKit
import SharedCore
import HomeAssembly
import SearchAssembly
import ProfileAssembly

final class MainTabBarCoordinator: Coordinator {
    // childCoordinators ინახავს შვილ კოორდინატორებს, რომ მეხსიერებიდან არ ამოვარდნენ (სამომავლოდ დაგვჭირდება)
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let tabBarController: MainTabBarController
    
    // ინიციალიზატორში გარედან შემოგვაქვს მთავარი ნავიგაცია
    init(navigationController: UINavigationController, tabBarController: MainTabBarController = MainTabBarController()) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        // 1. თითოეული ჩანართისთვის (ტაბისთვის) ვქმნით ცალკე ნავიგაციის კონტროლერს
        let homeNav = UINavigationController()
        let searchNav = UINavigationController()
        let profileNav = UINavigationController()
        
        // 2. ფექთორების დახმარებით ვიღებთ გამზადებულ ფერად ეკრანებს
        let homeVC = HomeFactory().makeHomeViewController()
        let searchVC = SearchFactory().makeSearchViewController()
        let profileVC = ProfileFactory().makeProfileViewController()
        
        // 3. თითოეულ ნავიგაციაში ძირძველ (პირველ) ეკრანად ვსვამთ ჩვენს ფერად ვიუებს
        homeNav.viewControllers = [homeVC]
        searchNav.viewControllers = [searchVC]
        profileNav.viewControllers = [profileVC]
        
        // 4. ვანიჭებთ ტაბბარ აითემებს (როგორც წინა ნაბიჯში ვქენით)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        // 5. ტაბბარ კონტროლერს ვაწვდით ამ აწყობილ ნავიგაციებს
        tabBarController.viewControllers = [homeNav, searchNav, profileNav]
        
        // 6. ჩვენს მთავარ ნავიგაციაში root ეკრანად ვსვამთ მთლიან ტაბბარს და ვმალავთ ზედა ნავს
        navigationController.setViewControllers([tabBarController], animated: false)
        navigationController.isNavigationBarHidden = true
    }
}
