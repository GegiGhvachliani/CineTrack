//
//  SearchRoutingProtocol.swift
//  Search
//

import SharedCore

@MainActor
public protocol SearchRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showActorDetails(actorID: Int)
}
