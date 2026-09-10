//
//  ExternalLinksScrollView.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 07/09/2026.
//

import SwiftUI
import ActorDetailsDomain

public struct ExternalLinksScrollView: View {

    // MARK: - Properties

    let links: [ActorExternalLink]
    let onLinkTap: (URL) -> Void

    // MARK: - Initialization

    public init(
        links: [ActorExternalLink],
        onLinkTap: @escaping (URL) -> Void
    ) {
        self.links = links
        self.onLinkTap = onLinkTap
    }

    // MARK: - Body

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(links) { link in
                    Button {
                        onLinkTap(link.url)
                    } label: {
                        linkImage(for: link)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(link.title)
                }
            }
        }
    }

    private func linkImage(for link: ActorExternalLink) -> Image {
        switch link.id {
        case ActorDetailsStrings.Content.facebook:
            Image("facebook", bundle: .module)
        case ActorDetailsStrings.Content.instagram:
            Image("instagram", bundle: .module)
        case ActorDetailsStrings.Content.tikTok:
            Image("tiktok", bundle: .module)
        case ActorDetailsStrings.Content.xPlatform:
            Image("twitter", bundle: .module)
        case ActorDetailsStrings.Content.youTube:
            Image("youtube", bundle: .module)
        case ActorDetailsStrings.Content.imdb:
            Image("imdb", bundle: .module)
        case ActorDetailsStrings.Content.wikiData:
            Image("wikipedia", bundle: .module)
        default:
            Image("personal", bundle: .module)
        }
    }
}
