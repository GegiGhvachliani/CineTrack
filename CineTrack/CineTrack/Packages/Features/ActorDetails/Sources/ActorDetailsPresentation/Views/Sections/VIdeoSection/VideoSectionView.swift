//
//  VideoSectionView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import ActorVideosDomain
import DesignSystemTokens

struct VideoSectionView: View {
    let videos: [ActorVideo]
    let onSeeAllTap: (() -> Void)? = nil
    @State private var selectedVideo: ActorVideo?

    var body: some View {
        if let featuredVideo = videos.first {
            VStack(spacing: 6) {
                header

                VideoCell(
                    video: featuredVideo,
                    width: nil,
                    height: 200,
                    titleLineLimit: 2,
                    onTap: { selectedVideo = featuredVideo }
                )
                .padding(.horizontal, 16)

                if videos.count > 1 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            ForEach(videos.dropFirst()) { video in
                                VideoCell(
                                    video: video,
                                    width: 120,
                                    height: 75,
                                    titleLineLimit: 2,
                                    onTap: { selectedVideo = video }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 113)
                }
            }
            .padding(.top, 15)
            .padding(.bottom, 5)
            .background(ColorTokens.Background.secondary)
            .sheet(item: $selectedVideo) { video in
                VideoDetailView(video: video)
            }
        }
    }

    private var header: some View {
        HStack(spacing: 8) {
            Capsule()
                .fill(ColorTokens.Brand.primary)
                .frame(width: 4, height: 25)

            Text("Videos")
                .font(TypographyTokens.headline)

            Spacer()

            if let onSeeAllTap {
                Button(action: onSeeAllTap) {
                    Text("See All")
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Button.textButton)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
}

private struct VideoDetailView: View {
    let video: ActorVideo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            VideoThumbnailView(video: video)
                .frame(height: 230)

            Text(video.video.name)
                .font(TypographyTokens.headline)
                .multilineTextAlignment(.center)

            Text("Video playback will be added here.")
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
