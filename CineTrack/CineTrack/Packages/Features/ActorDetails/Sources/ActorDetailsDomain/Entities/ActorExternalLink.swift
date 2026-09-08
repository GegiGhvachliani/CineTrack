//
//  ActorExternalLink.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//


import Foundation

public struct ActorExternalLink: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let url: URL

    public init(id: String, title: String, url: URL) {
        self.id = id
        self.title = title
        self.url = url
    }
}

public extension ActorExternalLinks {
    var links: [ActorExternalLink] {
        [
            makeLink(id: facebookID, title: "Facebook", baseURL: "https://www.facebook.com/"),
            makeLink(id: instagramID, title: "Instagram", baseURL: "https://www.instagram.com/"),
            makeLink(id: tiktokID, title: "TikTok", baseURL: "https://www.tiktok.com/@"),
            makeLink(id: twitterID, title: "X", baseURL: "https://x.com/"),
            makeLink(id: youtubeID, title: "YouTube", baseURL: "https://www.youtube.com/"),
            makeLink(id: imdbID, title: "IMDb", baseURL: "https://www.imdb.com/name/")
        ]
        .compactMap { $0 }
    }

    private func makeLink(id: String?, title: String, baseURL: String) -> ActorExternalLink? {
        guard let id, !id.isEmpty, let url = URL(string: "\(baseURL)\(id)") else {
            return nil
        }
        return ActorExternalLink(id: title, title: title, url: url)
    }
}
