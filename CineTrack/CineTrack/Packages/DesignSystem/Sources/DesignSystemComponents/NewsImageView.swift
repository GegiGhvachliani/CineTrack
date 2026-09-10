//
//  file.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI

public struct NewsImageView: View {

    // MARK: - Properties

    private let photoURL: String?
    private let height: CGFloat

    // MARK: - Initialization

    public init(photoURL: String?, height: CGFloat) {
        self.photoURL = photoURL
        self.height = height
    }

    // MARK: - Body

    public var body: some View {
        Color.clear
            .frame(height: height)
            .overlay {
                PosterImageView(photoURL: photoURL)
            }
            .clipped()
    }
}
