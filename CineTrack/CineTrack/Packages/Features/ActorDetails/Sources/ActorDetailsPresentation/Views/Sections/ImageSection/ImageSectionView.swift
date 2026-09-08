//
//  ImageSectionView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import ActorMediaDomain
import DesignSystemComponents

struct ImageSectionView: View {
    let images: [ActorMediaImage]
    let onLoadMore: () -> Void

    var body: some View {
        ImageGallerySectionView(
            items: images,
            imageURL: \.url,
            aspectRatio: \.aspectRatio,
            onLoadMore: onLoadMore
        )
    }
}
