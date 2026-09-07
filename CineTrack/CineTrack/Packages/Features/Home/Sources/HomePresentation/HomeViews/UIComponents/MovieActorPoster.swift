//
//  MovieActorPoster.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens
import DesignSystemComponents

struct MovieActorPoster: View {

    let isFavourited: Bool
    let photoURL: String?

    let onActorTap: () -> Void
    let onFavouriteTap: () -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            Button(action: onActorTap) {
                PosterImageView(photoURL: photoURL)
            }
            .buttonStyle(.plain)

            favouriteButton
        }
        .clipped()
    }

    private var favouriteButton: some View {
        Button(action: onFavouriteTap) {
            Circle()
                .frame(height: 25)
                .foregroundStyle(.black.opacity(0.5))
                .overlay {
                    Image(
                        systemName:
                            isFavourited
                            ? "heart.fill"
                            : "heart"
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(
                        isFavourited
                        ? ColorTokens.Brand.primary
                        : .white
                    )
                }
                .padding(.leading, 5)
                .padding(.bottom, 5)
        }
    }
}
