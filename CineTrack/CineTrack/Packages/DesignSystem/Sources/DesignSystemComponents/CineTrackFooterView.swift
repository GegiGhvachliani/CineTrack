//
//  file.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

public struct CineTrackFooterView: View {

    // MARK: - Initialization

    public init() {}

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 15) {
            header
            socialLinks
        }
        .padding(.vertical, 15)
        .background(ColorTokens.Background.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var header: some View {
        HStack(spacing: 8) {
            Capsule()
                .frame(width: 4, height: 25)
                .foregroundStyle(ColorTokens.Brand.primary)

            Text(DesignSystemStrings.Section.socialLinks)
                .font(TypographyTokens.headline)

            Spacer()
        }
        .padding(.horizontal)
    }

    private var socialLinks: some View {
        HStack(spacing: 20) {
            ForEach(links) { link in
                Link(destination: link.url) {
                    Image(link.imageName, bundle: .module)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }

            Spacer()
        }
        .padding(.horizontal)
    }

    private var links: [SocialLink] {
        [
            .init(imageName: "tikTok", url: "https://www.tiktok.com/@imdb"),
            .init(imageName: "instagram", url: "https://www.instagram.com/imdb/"),
            .init(imageName: "x", url: "https://x.com/IMDb"),
            .init(imageName: "youtube", url: "https://www.youtube.com/imdb"),
            .init(imageName: "facebook", url: "https://www.facebook.com/imdb/")
        ]
    }
}

private struct SocialLink: Identifiable {

    // MARK: - Properties

    let imageName: String
    let url: URL

    var id: String {
        imageName
    }

    // MARK: - Initialization

    init(imageName: String, url: String) {
        self.imageName = imageName
        self.url = URL(string: url)!
    }
}
