//
//  SeeAllFactory.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SeeAllPresentation
import SeeAllPresentationAPI
import SharedCore

@MainActor
public struct SeeAllFactory: SeeAllFactoryProtocol {

    public init() {}

    public func makeSeeAllViewController(
        content: SeeAllContent,
        onMovieTap: @escaping (Movie) -> Void,
        onActorTap: @escaping (Actor) -> Void,
        onNewsTap: @escaping (News) -> Void
    ) -> UIViewController {
        let view = SeeAllView(
            content: content,
            onMovieTap: onMovieTap,
            onActorTap: onActorTap,
            onNewsTap: onNewsTap
        )

        let viewController = UIHostingController(rootView: view)
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium(), .large()]
        viewController.sheetPresentationController?.prefersGrabberVisible = true
        return viewController
    }
}
