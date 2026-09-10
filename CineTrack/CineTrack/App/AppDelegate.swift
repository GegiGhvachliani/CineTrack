//
//  AppDelegate.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 05/06/2026.
//

import UIKit
import Firebase
import GoogleSignIn

@main  // @main ეუბნება აპს რომ ამ კლასიდან დაიწყოს აპლიკაცია
class AppDelegate: UIResponder, UIApplicationDelegate {

    // ერთხელ იძახება აპის გაშვებისას, სანამ FireBase-ს გამოვიყენებ
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()  // აკონფიგურირებს Firebase-ს რომ FirebaseUserSession, FirestoreClient და Google Sign-In-მა სწორად იმუშაოს

        return true
    }

    // MARK: - Google Sign-In URL Handling

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }
        return false
    }

    // MARK: - UISceneSession Lifecycle

    func application(
        _ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
