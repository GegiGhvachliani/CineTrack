//
//  PosterWithVideoView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import HomeDomain
import DesignSystemTokens
import DesignSystemComponents

// MARK: - Poster With Video

public struct PosterWithVideoView: View {

    // MARK: - Properties

    let featuredItem: FeaturedItem

    let isWatchlisted: Bool

    let onVideoTap: () -> Void
    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void

    public var body: some View {

        VStack(spacing: 0) {

            ZStack(alignment: .bottomLeading) {

                VStack(spacing: 0) {

                    backgroundButton

                    footer
                }

                moviePoster
                    .frame(
                        width: 100,
                        height: 150
                    )
                    .padding(.leading, 20)
            }
            .background(
                ColorTokens.Background.primary
            )
        }
    }

    // MARK: - Video

    private var backgroundButton: some View {

        Button(action: onVideoTap) {

            ZStack {

                videoImage

                Image(systemName: "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundStyle(ColorTokens.Text.onImage)
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Video Image

    private var videoImage: some View {

        AsyncImage(
            url: videoThumbnailURL
        ) { phase in

            switch phase {

            case .empty:

                Rectangle()
                    .fill(ColorTokens.Media.placeholder)
                    .overlay {
                        ProgressView()
                    }

            case .success(let image):

                image
                    .resizable()
                    .scaledToFill()

            case .failure:

                Rectangle()
                    .fill(ColorTokens.Media.placeholder)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(ColorTokens.Text.secondary)
                    }

            @unknown default:

                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 210)
        .clipped()
    }

    // MARK: - Footer

    private var footer: some View {

        HStack {

            Color.clear
                .frame(
                    width: 110,
                    height: 50
                )

            Text(featuredItem.video.name)
                .font(
                    .system(
                        size: 13,
                        weight: .regular
                    )
                )
                .foregroundStyle(
                    ColorTokens.Text.primary
                )
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }

    // MARK: - Movie Poster

    private var moviePoster: some View {

        ZStack(alignment: .topLeading) {

            Button(action: onMovieTap) {

                AsyncImage(
                    url: URL(
                        string:
                            featuredItem.movie.posterPath ?? ""
                    )
                ) { phase in

                    switch phase {

                    case .empty:

                        Rectangle()
                            .fill(
                                ColorTokens.Media.placeholder
                            )
                            .overlay {
                                ProgressView()
                            }

                    case .success(let image):

                        image
                            .resizable()
                            .scaledToFill()

                    case .failure:

                        Rectangle()
                            .fill(
                                ColorTokens.Media.placeholder
                            )
                            .overlay {
                                Image(
                                    systemName: "photo"
                                )
                                .foregroundStyle(ColorTokens.Text.secondary)
                            }

                    @unknown default:

                        EmptyView()
                    }
                }
            }
            .buttonStyle(.plain)

            LinearGradient(
                colors: [
                    ColorTokens.Media.scrim.opacity(0.6),
                    .clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 70)

            WatchlistButton(
                isAdded: isWatchlisted,
                action: onWatchlistTap
            )
        }
        .clipped()
    }

    // MARK: - YouTube Thumbnail

    private var videoThumbnailURL: URL? {

        guard featuredItem.video.site == .youtube else {
            return nil
        }

        return URL(
            string:
                "https://img.youtube.com/vi/\(featuredItem.video.key)/hqdefault.jpg"
        )
    }
}
