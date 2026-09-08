import UIKit
import SharedCore
import HomePresentationAPI
import SearchPresentationAPI
import ProfilePresentationAPI
import ActorDetailsPresentationAPI
import MovieDetailsPresentationAPI
import NewsDetailsPresentationAPI
import SeeAllPresentationAPI
import VideosListPresentationAPI

final class MainTabBarCoordinator: Coordinator, HomeRoutingProtocol, ActorDetailsRoutingProtocol, MovieDetailsRoutingProtocol {
    // childCoordinators ინახავს შვილ კოორდინატორებს, რომ მეხსიერებიდან არ ამოვარდნენ (სამომავლოდ დაგვჭირდება)
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let tabBarController: MainTabBarController
    private let container: AppDIContainerProtocol
    
    private weak var homeNavigationController: UINavigationController?
    
    // ინიციალიზატორში გარედან შემოგვაქვს მთავარი ნავიგაცია
    init(
        navigationController: UINavigationController,
        tabBarController: MainTabBarController = MainTabBarController(),
        container: AppDIContainerProtocol
    ) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.container = container
    }
    
    func start() {
        // 1. თითოეული ჩანართისთვის (ტაბისთვის) ვქმნით ცალკე ნავიგაციის კონტროლერს, რადგან თითოეულს აქვს თავისი ნავიგაციის ისტორია
        let homeNav = UINavigationController()
        let searchNav = UINavigationController()
        let profileNav = UINavigationController()
        
        // 2. ფექთორების დახმარებით ვიღებთ გამზადებულ ფერად ეკრანებს
        homeNavigationController = homeNav

        let homeCoordinator = container.homeFactory.makeHomeCoordinator(
            navigationController: homeNav,
            router: self
        )
        let searchCoordinator = container.searchFactory.makeSearchCoordinator(navigationController: searchNav)
        let profileCoordinator = container.profileFactory.makeProfileCoordinator(navigationController: profileNav)
        
        // 3. თითოეულ ნავიგაციაში პირველ ეკრანად ვსვამთ ჩვენს ფერად ვიუებს
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(profileCoordinator)
        
        homeCoordinator.start()
        searchCoordinator.start()
        profileCoordinator.start()
        
        // 4. ვანიჭებთ ტაბბარ აითემებს
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        // 5. ტაბბარ კონტროლერს ვაწვდით ამ აწყობილ ნავიგაციებს
        tabBarController.viewControllers = [homeNav, searchNav, profileNav]
        
        // 6. ჩვენს მთავარ ნავიგაციაში root ეკრანად ვსვამთ მთლიან ტაბბარს და ვმალავთ ზედა ნავს
        navigationController.setViewControllers([tabBarController], animated: false)
        navigationController.isNavigationBarHidden = true
    }
    
    func showActorDetails(actorID: Int) {
        guard let homeNavigationController else { return }

        let coordinator = container.actorDetailsFactory.makeActorDetailsCoordinator(
            actorID: actorID,
            navigationController: homeNavigationController,
            router: self
        )
        addChild(coordinator)
        coordinator.start()
    }
    
    func showMovieDetails(movie: Movie) {
        guard let homeNavigationController else {
            return
        }

        let coordinator = container.movieDetailsFactory.makeMovieDetailsCoordinator(
            movie: movie,
            navigationController: homeNavigationController,
            router: self
        )
        addChild(coordinator)
        coordinator.start()
    }
    
    func showNewsDetails(news: News) {
        let viewController = container.newsDetailsFactory.makeNewsDetailsViewController(news: news)
        
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSeeAll(section: HomeSection) {
        let viewController = container.seeAllFactory.makeSeeAllViewController(section: section)
        
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func showVideosList(item: FeaturedItem) {
        let viewController = container.videosListFactory.makeVideosListViewController(item: item)
        
        homeNavigationController?.pushViewController(viewController, animated: true)
    }
}
