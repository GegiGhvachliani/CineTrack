//
//  ImageSectionView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemComponents

struct ImageSectionView: View {

    // MARK: - Properties

    let images: [ActorMediaImage]
    let onLoadMore: () -> Void
    let onSeeAllTap: () -> Void

    // MARK: - Body

    var body: some View {
        ImageGallerySectionView(
            items: images,
            imageURL: \.url,
            aspectRatio: \.aspectRatio,
            onSeeAllTap: onSeeAllTap,
            onLoadMore: onLoadMore
        )
    }
}
