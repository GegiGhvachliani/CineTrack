//
//  file.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

public struct PosterImageView: View {

    // MARK: - Properties

    private let photoURL: String?

    // MARK: - Initialization

    public init(photoURL: String?) {
        self.photoURL = photoURL
    }

    // MARK: - Body

    public var body: some View {
        AsyncImage(url: URL(string: photoURL ?? "")) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(ColorTokens.Media.placeholder)
                    .overlay { ProgressView() }
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }
}
