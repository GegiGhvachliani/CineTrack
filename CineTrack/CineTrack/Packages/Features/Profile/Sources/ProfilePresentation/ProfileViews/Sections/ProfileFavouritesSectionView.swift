//
//  ProfileFavouritesSectionView.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct ProfileFavouritesSectionView: View {

    // MARK: - Properties

    let actors: [Actor]
    let onActorTap: (Actor) -> Void
    let onFavouriteTap: (Actor) -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        if actors.isEmpty {
            ProfileEmptySectionView(
                title: ProfileStrings.Content.favourited,
                message: ProfileStrings.Content.yourFavouritePeopleWillAppearHere,
                detail: ProfileStrings.Content.tapTheHeartOnAPersonsCardTo
            )
        } else {
            HorizontalScrollView(
                headerText: ProfileStrings.Content.favourited,
                seeAllTitle: ProfileStrings.Content.seeAll,
                items: actors,
                onSeeAllTap: onSeeAllTap
            ) { actor, _ in
                MovieActorCell(
                    actor: actor,
                    cellHeight: 240,
                    isFavourited: true,
                    onActorTap: { onActorTap(actor) },
                    onFavouriteTap: {
                        onFavouriteTap(actor)
                    }
                )
            }
        }
    }
}
