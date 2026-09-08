//
//  ExternalLinksScrollView.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 07/09/2026.
//

import SwiftUI
import ActorDetailsDomain

public struct ExternalLinksScrollView: View {
    
    let links: [ActorExternalLink]
    let onLinkTap: (URL) -> Void
    
    public init(
        links: [ActorExternalLink],
        onLinkTap: @escaping (URL) -> Void
    ) {
        self.links = links
        self.onLinkTap = onLinkTap
    }
    
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
        case "Facebook":
            Image("facebook", bundle: .module)
        case "Instagram":
            Image("instagram", bundle: .module)
        case "TikTok":
            Image("tiktok", bundle: .module)
        case "X":
            Image("twitter", bundle: .module)
        case "YouTube":
            Image("youtube", bundle: .module)
        case "IMDb":
            Image("imdb", bundle: .module)
        case "WikiData":
            Image("wikipedia", bundle: .module)
        default:
            Image("personal", bundle: .module)
        }
    }
}
