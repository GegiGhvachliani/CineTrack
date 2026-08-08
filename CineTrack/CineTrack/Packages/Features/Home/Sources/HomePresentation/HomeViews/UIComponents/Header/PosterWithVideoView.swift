//
//  PosterWithVideoView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 03/08/2026.
//

import SwiftUI
import DesignSystemTokens
import SharedCore
import HomeDomain

struct PosterWithVideoView: View {

    let featuredItem: FeaturedItem

    let isWatchlisted: Bool

    let onVideoTap: () -> Void
    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void

    var body: some View {

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
            .background(ColorTokens.Background.primary)
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
                    .foregroundStyle(.white)
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
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                    }

            case .success(let image):

                image
                    .resizable()
                    .scaledToFill()

            case .failure:

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.gray)
                    }

            @unknown default:

                EmptyView()
            }
        }
        .frame(
            maxWidth: .infinity
        )
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
                .foregroundColor(ColorTokens.Text.primary)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.black.opacity(0.8))
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
                            .fill(Color.gray.opacity(0.3))
                            .overlay {
                                ProgressView()
                            }

                    case .success(let image):

                        image
                            .resizable()
                            .scaledToFill()

                    case .failure:

                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay {
                                Image(
                                    systemName: "photo"
                                )
                                .foregroundStyle(.gray)
                            }

                    @unknown default:

                        EmptyView()
                    }
                }
            }
            .buttonStyle(.plain)

            LinearGradient(
                colors: [
                    .black.opacity(0.6),
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

//// MARK: - Preview
//
//#Preview {
//    
//    let movie = Movie(
//        id: 3,
//        title: "Spider-Man: No Way Home",
//        overview: "",
//        posterPath:
//            "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
//        backdropPath: nil,
//        releaseDate: "2021-12-17",
//        voteAverage: 8.9,
//        voteCount: 12000
//    )
//    
//    let video = MovieVideo(
//        id: "preview-video",
//        key: "JfVOs4VSpmA",
//        name: "Official Trailer",
//        site: .youtube,
//        type: .trailer,
//        official: true
//    )
//    
//    let featuredItem = FeaturedItem(
//        movie: movie,
//        video: video
//    )
//    
//    PosterWithVideoView(
//        featuredItem: featuredItem,
//        addedInWatchlist: .constant(true),
//        onVideoTap: {
//            print("Navigate to Videos Feature")
//        }
//    )
//    .frame(height: 140)
//}
