//
//  BornTodaySectionView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import DesignSystemComponents

struct BornTodaySectionView: View {

    // MARK: - Properties

    let actors: [Actor]
    let favouritedActors: [Actor]

    let onActorTap: (Actor) -> Void
    let onFavouriteTap: (Actor) -> Void
    let onSeeAllTap: () -> Void
    let onLoadMore: () -> Void

    // MARK: - Body

    var body: some View {

        HorizontalScrollView(
            headerText: HomeStrings.Section.bornToday,
            seeAllTitle: HomeStrings.Action.seeAll,
            items: actors,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        ) { actor, _ in

            MovieActorCell(
                actor: actor,
                cellHeight: 240,
                isFavourited: favouritedActors.contains {
                    $0.id == actor.id
                },
                onActorTap: { onActorTap(actor) },
                onFavouriteTap: { onFavouriteTap(actor) }
            )

        }
    }

}
