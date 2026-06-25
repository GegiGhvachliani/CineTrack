//
//  SceneDelegate.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 05/06/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var appDIContainer: AppDIContainerProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let container = AppDIContainer()
        self.appDIContainer = container
        
        // ვაინიციალიზებთ მთავარ კოორდინატორს
        appCoordinator = AppCoordinator(window: window, container: container)
        appCoordinator?.start()
        
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
