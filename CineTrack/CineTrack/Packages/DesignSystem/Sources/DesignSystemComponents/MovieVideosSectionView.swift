//
//  file.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemTokens

public struct MovieVideosSectionView: View {

    // MARK: - Properties

    private let videos: [MovieVideo]
    private let onVideoTap: (MovieVideo) -> Void

    // MARK: - Initialization

    public init(
        videos: [MovieVideo],
        onVideoTap: @escaping (MovieVideo) -> Void
    ) {
        self.videos = videos
        self.onVideoTap = onVideoTap
    }

    // MARK: - Body

    public var body: some View {
        if let featuredVideo {
            VStack(spacing: 6) {
                sectionHeader
                VideoCell(video: featuredVideo, width: nil, height: 200) {
                    onVideoTap(featuredVideo)
                }
                .padding(.horizontal, 16)

                if !additionalVideos.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            ForEach(additionalVideos) { video in
                                VideoCell(video: video, width: 120, height: 75) {
                                    onVideoTap(video)
                                }
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

        }
    }

    // MARK: - Content

    private var featuredVideo: MovieVideo? {
        videos.first { $0.type != .trailer }
    }

    private var additionalVideos: [MovieVideo] {
        guard let featuredVideo else {
            return []
        }

        return videos.filter { $0.id != featuredVideo.id }
    }

    private var sectionHeader: some View {
        HStack(spacing: 8) {
            Capsule().fill(ColorTokens.Brand.primary).frame(width: 4, height: 25)
            Text(DesignSystemStrings.Section.videos).font(TypographyTokens.headline)
            Spacer()
        }
        .padding(.horizontal)
    }

}
