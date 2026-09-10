//
//  MostPopularActorsSectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import DesignSystemComponents

struct MostPopularActorsSectionView: View {

    // MARK: - Properties

    let actors: [Actor]
    let favouriteActors: [Actor]

    let onActorTap: (Actor) -> Void
    let onFavouriteTap: (Actor) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void

    // MARK: - Body

    var body: some View {

        HorizontalScrollView(
            headerText: HomeStrings.Section.mostPopularCelebrities,
            seeAllTitle: HomeStrings.Action.seeAll,
            items: actors,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        ) { actor, _ in

            MovieActorCell(
                actor: actor,
                cellHeight: 240,
                isFavourited: favouriteActors.contains {
                    $0.id == actor.id
                },
                onActorTap: { onActorTap(actor) },
                onFavouriteTap: { onFavouriteTap(actor) }
            )

        }
    }

}
