//
//  MovieActorPoster.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import LibraryDomain
import DesignSystemTokens

struct MovieActorPoster: View {

    // MARK: - Properties

    let isFavourited: Bool
    let photoURL: String?

    let onActorTap: () -> Void
    let onFavouriteTap: () -> Void

    // MARK: - Body

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
            if let photoURL, let url = imageURL(from: photoURL) {
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

    private func imageURL(from path: String) -> URL? {
        if path.hasPrefix("http") {
            return URL(string: path)
        }

        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    private var favouriteButton: some View {
        Button(action: onFavouriteTap) {
            Circle()
                .frame(height: 25)
                .foregroundStyle(ColorTokens.Media.scrim.opacity(0.5))
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
                            : ColorTokens.Text.onImage
                    )
                }
                .padding(.leading, 5)
                .padding(.bottom, 5)
        }
    }
}
