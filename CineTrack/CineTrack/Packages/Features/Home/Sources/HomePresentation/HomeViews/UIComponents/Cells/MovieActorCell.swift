//
//  MovieActorCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import SwiftUI
import DesignSystemTokens
import SharedCore

public struct MovieActorCell: View {

    let actor: Actor
    let cellHeight: CGFloat
    let isFavourited: Bool

    let onActorTap: () -> Void
    let onFavouriteTap: () -> Void

    public var body: some View {
        Button(action: onActorTap) {
            VStack(spacing: 0) {
                
                header
                
                footer
            }
            .frame(
                width: cellHeight * (8.0 / 15.0),
                height: cellHeight
            )
            .foregroundStyle(.white)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 5,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 5
                )
            )
        }
    }

    private var header: some View {

        MovieActorPoster(
            isFavourited: isFavourited,
            photoURL: actor.profilePath,
            onActorTap: onActorTap,
            onFavouriteTap: onFavouriteTap
        )
    }

    private var footer: some View {

        VStack(alignment: .leading) {

            Text(actor.name)
                .font(DesignSystemTokens.TypographyTokens.caption)
                .foregroundStyle(ColorTokens.Text.main)
                .lineLimit(2)

            if let age = actor.age {

                Text(String(age))
                    .font(DesignSystemTokens.TypographyTokens.caption)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 3)
        .frame(maxWidth: .infinity,alignment: .leading)
        .frame(height: cellHeight * 0.2 + 10)
        .background(ColorTokens.Background.primary)
    }
}
