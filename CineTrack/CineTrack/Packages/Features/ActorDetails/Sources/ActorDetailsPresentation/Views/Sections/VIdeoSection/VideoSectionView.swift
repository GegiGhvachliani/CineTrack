//
//  VideoSectionView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import ActorVideosDomain
import DesignSystemComponents

struct VideoSectionView: View {
    let videos: [ActorVideo]
    var body: some View {
        MovieVideosSectionView(videos: videos.map(\.video))
    }
}
