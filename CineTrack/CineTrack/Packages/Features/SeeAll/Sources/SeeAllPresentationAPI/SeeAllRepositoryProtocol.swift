//
//  SeeAllRepositoryProtocol.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol SeeAllFactoryProtocol {

    func makeSeeAllViewController(
        content: SeeAllContent,
        onMovieTap: @escaping (Movie) -> Void,
        onActorTap: @escaping (Actor) -> Void,
        onNewsTap: @escaping (News) -> Void
    ) -> UIViewController
}
