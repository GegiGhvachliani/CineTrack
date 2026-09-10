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

final class MainTabBarCoordinator: NSObject, MainTabBarCoordinatorProtocol, VideosListRoutingProtocol,
    SeeAllRoutingProtocol, HomeRoutingProtocol, SearchRoutingProtocol, ActorDetailsRoutingProtocol,
    MovieDetailsRoutingProtocol, ProfileRoutingProtocol, UINavigationControllerDelegate {

    // MARK: - Properties

    var onSignedOut: (() -> Void)?
    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController
    private let tabBarController: MainTabBarController
    private let container: AppDIContainerProtocol

    private weak var homeNavigationController: UINavigationController?
    private var detailCoordinators: [ObjectIdentifier: Coordinator] = [:]
    private var seeAllCoordinator: SeeAllCoordinatorProtocol?
    private var fullScreenViewControllerIDs = Set<ObjectIdentifier>()

    // ინიციალიზატორში გარედან შემოგვაქვს მთავარი ნავიგაცია

    // MARK: - Initialization

    init(
        navigationController: UINavigationController,
        tabBarController: MainTabBarController = MainTabBarController(),
        container: AppDIContainerProtocol
    ) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.container = container
        super.init()
    }

    func start() {
        // 1. თითოეული ჩანართისთვის (ტაბისთვის) ვქმნით ცალკე ნავიგაციის კონტროლერს, რადგან თითოეულს აქვს თავისი ნავიგაციის ისტორია
        let homeNav = UINavigationController()
        let searchNav = UINavigationController()
        let profileNav = UINavigationController()

        homeNav.delegate = self
        searchNav.delegate = self
        profileNav.delegate = self

        // 2. ფექთორების დახმარებით ვიღებთ გამზადებულ ფერად ეკრანებს
        homeNavigationController = homeNav

        let homeCoordinator = container.homeFactory.makeHomeCoordinator(
            navigationController: homeNav,
            router: self
        )
        let searchCoordinator = container.searchFactory.makeSearchCoordinator(
            navigationController: searchNav,
            router: self
        )
        let profileCoordinator = container.profileFactory.makeProfileCoordinator(
            navigationController: profileNav, router: self)

        // 3. თითოეულ ნავიგაციაში პირველ ეკრანად ვსვამთ ჩვენს ფერად ვიუებს
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(profileCoordinator)

        homeCoordinator.start()
        searchCoordinator.start()
        profileCoordinator.start()

        // 4. ვანიჭებთ ტაბბარ აითემებს
        homeNav.tabBarItem = UITabBarItem(title: AppStrings.Tab.home, image: UIImage(systemName: "house"), tag: 0)
        searchNav.tabBarItem = UITabBarItem(
            title: AppStrings.Tab.search, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        profileNav.tabBarItem = UITabBarItem(
            title: AppStrings.Tab.profile, image: UIImage(systemName: "person"), tag: 2)

        // 5. ტაბბარ კონტროლერს ვაწვდით ამ აწყობილ ნავიგაციებს
        tabBarController.viewControllers = [homeNav, searchNav, profileNav]

        // 6. ჩვენს მთავარ ნავიგაციაში root ეკრანად ვსვამთ მთლიან ტაბბარს და ვმალავთ ზედა ნავს
        navigationController.setViewControllers([tabBarController], animated: false)
        navigationController.isNavigationBarHidden = true
    }

    func showSearch() {
        tabBarController.selectedIndex = 1
    }

    func didSignOut() {
        seeAllCoordinator = nil
        detailCoordinators.removeAll()
        fullScreenViewControllerIDs.removeAll()
        childCoordinators.removeAll()
        onSignedOut?()
    }

    func showActorDetails(actorID: Int) {
        guard let activeNavigationController else { return }

        activeNavigationController.setNavigationBarHidden(false, animated: true)

        let coordinator = container.actorDetailsFactory.makeActorDetailsCoordinator(
            actorID: actorID,
            navigationController: activeNavigationController,
            router: self
        )
        coordinator.start()
        retainDetailCoordinator(coordinator, for: activeNavigationController)
    }

    func showMovieDetails(movie: Movie) {
        guard let activeNavigationController else {
            return
        }

        activeNavigationController.setNavigationBarHidden(false, animated: true)

        let coordinator = container.movieDetailsFactory.makeMovieDetailsCoordinator(
            movie: movie,
            navigationController: activeNavigationController,
            router: self
        )
        coordinator.start()
        retainDetailCoordinator(coordinator, for: activeNavigationController)
    }

    func showNewsDetails(news: News) {
        guard let activeNavigationController else {
            return
        }

        activeNavigationController.setNavigationBarHidden(false, animated: true)
        let coordinator = container.newsDetailsFactory.makeNewsDetailsCoordinator(
            news: news,
            navigationController: activeNavigationController
        )
        coordinator.start()
        retainDetailCoordinator(coordinator, for: activeNavigationController)
    }

    func showSeeAll(content: SeeAllContent) {
        guard let activeNavigationController, seeAllCoordinator == nil else {
            return
        }

        let coordinator = container.seeAllFactory.makeSeeAllCoordinator(
            content: content,
            presentingController: activeNavigationController,
            router: self
        )
        coordinator.onFinish = { [weak self] in
            self?.seeAllCoordinator = nil
        }
        seeAllCoordinator = coordinator
        coordinator.start()
    }

    private var activeNavigationController: UINavigationController? {
        tabBarController.selectedViewController as? UINavigationController ?? homeNavigationController
    }

    func showVideosList(context: VideoPlaylistContext) {
        guard let activeNavigationController else {
            return
        }

        let coordinator = container.videosListFactory.makeVideosListCoordinator(
            context: context,
            navigationController: activeNavigationController,
            router: self
        )
        coordinator.start()
        retainDetailCoordinator(coordinator, for: activeNavigationController)

        if let viewController = activeNavigationController.topViewController {
            fullScreenViewControllerIDs.insert(ObjectIdentifier(viewController))
        }
    }

    func showMovieDetails(from context: VideoPlaylistContext) {
        guard let navigationController = activeNavigationController else {
            return
        }

        navigationController.popViewController(animated: false)

        switch context.source {
        case .movieDetails:
            break
        case .home, .actorDetails:
            showMovieDetails(movie: context.movie)
        }
    }

    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        let navigationControllers = (tabBarController.viewControllers ?? []).compactMap {
            $0 as? UINavigationController
        }
        let activeViewControllerIDs = Set(navigationControllers.flatMap(\.viewControllers).map(ObjectIdentifier.init))
        detailCoordinators = detailCoordinators.filter { activeViewControllerIDs.contains($0.key) }
        fullScreenViewControllerIDs = fullScreenViewControllerIDs.intersection(activeViewControllerIDs)

        let isRootViewController = navigationController.viewControllers.first === viewController
        let isFullScreenViewController = fullScreenViewControllerIDs.contains(ObjectIdentifier(viewController))
        navigationController.setNavigationBarHidden(
            isRootViewController || isFullScreenViewController,
            animated: animated
        )
    }

    private func retainDetailCoordinator(
        _ coordinator: Coordinator,
        for navigationController: UINavigationController
    ) {
        guard let detailViewController = navigationController.topViewController else {
            return
        }

        detailCoordinators[ObjectIdentifier(detailViewController)] = coordinator
    }
}
