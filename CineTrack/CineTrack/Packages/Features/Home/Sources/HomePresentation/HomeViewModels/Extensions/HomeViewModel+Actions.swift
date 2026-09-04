//
//  HomeViewModel+Actions.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    public func didTapSearch() {
        onSearch?()
    }

    public func didTapMovie(_ movie: Movie) {
        onMovieDetails?(movie)
    }

    public func didTapVideos(_ item: FeaturedItem) {
        onVideos?(item)
    }

    public func didTapActor(_ actor: Actor) {
        onActorDetails?(actor)
    }

    public func didTapSeeAll(_ section: HomeSection) {
        onSeeAll?(section)
    }

    public func didTapNews(_ news: News) {
        onNewsDetails?(news)
    }
}
