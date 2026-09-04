//
//  ActorDetailsFactory.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SharedCore
import ActorDetailsPresentation
import ActorDetailsPresentationAPI

@MainActor
public struct ActorDetailsFactory: ActorDetailsFactoryProtocol {

    public init() {}

    public func makeActorDetailsViewController(actor: Actor) -> UIViewController {
        let view = ActorDetailsView(actor: actor)

        return UIHostingController(rootView: view)
    }
}
