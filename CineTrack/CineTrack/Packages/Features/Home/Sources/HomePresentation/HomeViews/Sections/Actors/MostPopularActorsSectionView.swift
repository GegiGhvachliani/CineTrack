//
//  MostPopularActorsSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import SharedCore

struct MostPopularActorsSectionView: View {
    
    let actors: [Actor]
    let favouriteActorIDs: Set<Int>
    
    let onActorTap: (Actor) -> Void
    let onFavouriteTap: (Actor) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void
    
    var body: some View {
        
        HorizontalScrollView(
            headerText: "Most popular celebrities",
            items: actors,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        ) { actor, _ in
            
            MovieActorCell(
                actor: actor,
                cellHeight: 240,
                isFavourited: favouriteActorIDs.contains(actor.id),
                onActorTap: { onActorTap(actor) },
                onFavouriteTap: { onFavouriteTap(actor) }
            )
            
        }
    }
    
}
