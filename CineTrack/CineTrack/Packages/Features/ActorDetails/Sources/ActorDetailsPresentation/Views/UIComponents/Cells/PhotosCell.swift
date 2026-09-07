//
//  PhotosCell.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI

import ActorDetailsDomain
import DesignSystemTokens

public struct PhotosCell: View {

    let image: ActorImage

    public init(image: ActorImage) {
        self.image = image
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            asyncImage
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }

    private var asyncImage: some View {
        AsyncImage(
            url: URL(string: image.filePath)
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
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)

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
        .frame(maxWidth: .infinity)
        .clipped()
    }
}

#Preview {
    PhotosCell(
        image: ActorImage(
            id: "preview",
            filePath: "https://image.tmdb.org/t/p/w780/abc.jpg",
            width: 780,
            height: 1170,
            aspectRatio: 0.67,
            voteAverage: 8.2,
            voteCount: 100
        )
    )
}
