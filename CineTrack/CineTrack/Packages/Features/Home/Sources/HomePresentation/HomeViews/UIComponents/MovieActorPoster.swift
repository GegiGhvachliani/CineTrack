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
                actorProfileImage
            }
            .buttonStyle(.plain)

            favouriteButton
        }
        .clipped()
    }

    private var actorProfileImage: some View {
        Group {
            if let photoURL, let url = URL(string: photoURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        loadingView
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        missingPhotoView
                    @unknown default:
                        missingPhotoView
                    }
                }
            } else {
                missingPhotoView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }

    private var loadingView: some View {
        Rectangle()
            .fill(ColorTokens.Background.primary)
            .overlay {
                ProgressView()
                    .tint(ColorTokens.Brand.primary)
            }
    }

    private var missingPhotoView: some View {
        Rectangle()
            .fill(ColorTokens.Background.primary)
            .overlay {
                Image(systemName: "person.fill")
                    .font(.system(size: 34, weight: .medium))
                    .foregroundStyle(ColorTokens.Brand.primary.opacity(0.8))
            }
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
