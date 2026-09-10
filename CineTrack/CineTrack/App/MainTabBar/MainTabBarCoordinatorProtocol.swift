import SharedCore

protocol MainTabBarCoordinatorProtocol: Coordinator {
    var onSignedOut: (() -> Void)? { get set }
}
