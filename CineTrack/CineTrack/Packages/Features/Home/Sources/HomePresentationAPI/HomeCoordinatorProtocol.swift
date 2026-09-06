//
//  HomeCoordinatorProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit
import SharedCore
import HomeDomain

public protocol HomeCoordinatorProtocol: Coordinator {

    var navigationController: UINavigationController { get }

    func showSearch()
    func showVideos(item: FeaturedItem)
    func showSeeAll(section: HomeSection)
    
    func showMovieDetails(movie: Movie)
    func showActorDetails(actorID: Int)
    func showNewsDetail(news: News)
}
