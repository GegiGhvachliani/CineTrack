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

        Task {
            await addRecentlyViewed(movie: movie)
        }
    }

    public func didTapActor(_ actor: Actor) {
        onActorDetails?(actor.id)

        Task {
            await addRecentlyViewed(actor: actor)
        }
    }
    
    public func didTapVideos(_ item: FeaturedItem) {
        onVideos?(item)
    }

    public func didTapSeeAll(_ section: HomeSection) {
        onSeeAll?(section)
    }

    public func didTapNews(_ news: News) {
        onNewsDetails?(news)
    }
}
