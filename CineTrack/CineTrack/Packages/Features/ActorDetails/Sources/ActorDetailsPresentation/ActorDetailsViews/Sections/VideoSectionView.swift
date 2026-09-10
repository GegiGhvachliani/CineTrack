//
//  VideoSectionView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemComponents

struct VideoSectionView: View {

    // MARK: - Properties

    let videos: [ActorVideo]
    let onVideoTap: (ActorVideo) -> Void

    // MARK: - Body

    var body: some View {
        MovieVideosSectionView(videos: videos.map(\.video)) { video in
            guard let actorVideo = videos.first(where: { $0.video.id == video.id }) else {
                return
            }
            onVideoTap(actorVideo)
        }
    }
}
