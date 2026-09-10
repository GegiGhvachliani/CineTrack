//
//  SceneDelegate.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 05/06/2026.
//

import UIKit
import SharedCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // თუ coordinator მხოლოდ ლოკალური ცვლადი იქნებოდა, willConnectTo მეთოდის დასრულების შემდეგ მეხსიერებიდან გათავისუფლდებოდა. ამიტომ SceneDelegate ძლიერ reference-ს ინახავს.
    var window: UIWindow?
    var appCoordinator: AppCoordinatorProtocol?
    var appDIContainer: AppDIContainerProtocol?

    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // ხელით ვქმნი აპის მთავარ UIWindows-ს, რომელშიც ყველა ეკრანი გამოჩნდება
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        // ვქმნი დეფენდესი კონტეინერს, რომელმაც იცის რომელი Factory შექმნას
        let container = AppDIContainer()
        self.appDIContainer = container

        // AppCoordinator-ს ვაძლევ windows-ს რომ მასში root ეკრანი ჩასვას და container-ს რომ ფიჩერების ფექტორები მოითქოხოვოს
        appCoordinator = AppCoordinator(window: window, container: container)
        appCoordinator?.start()

        // windows-ს ეკრანზე აჩენს და მას აქტიურს ხდის
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
