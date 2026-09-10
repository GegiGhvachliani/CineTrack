//
//  ProfileRoutingProtocol.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol ProfileRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showActorDetails(actorID: Int)
    func showSeeAll(content: SeeAllContent)
    func didSignOut()
}
