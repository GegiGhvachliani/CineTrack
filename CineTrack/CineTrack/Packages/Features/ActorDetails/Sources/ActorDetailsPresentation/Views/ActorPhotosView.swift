//
//  ActorPhotosView.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 06/09/2026.
//


import SwiftUI

import ActorDetailsDomain

public struct ActorPhotosView: View {
    private let images: [ActorImage]
    private let actorName: String

    public init(
        images: [ActorImage],
        actorName: String
    ) {
        self.images = images
        self.actorName = actorName
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(
                        .adaptive(minimum: 140),
                        spacing: 12
                    )
                ],
                spacing: 12
            ) {
                ForEach(images) { image in
                    PhotosCell(image: image)
                        .frame(height: 220)
                }
            }
            .padding()
        }
        .navigationTitle("\(actorName) Photos")
    }
}