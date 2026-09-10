//
//  WebSites.swift
//  Home
//
//  Created by Gegi Ghvachliani on 07/08/2026.
//

import Foundation

public enum Websites {
    case netflix
    case disneyPlus
    case paramountPlus
    case primeVideo
    case tikTok
    case instagram
    case xxx
    case youtube
    case facebook

    public var linkString: String {
        switch self {
        case .netflix:
            return "https://www.netflix.com"
        case .disneyPlus:
            return "https://www.disneyplus.com"
        case .paramountPlus:
            return "https://www.paramountplus.com"
        case .primeVideo:
            return "https://www.primevideo.com"
        case .tikTok:
            return "https://www.tiktok.com/@imdb"
        case .instagram:
            return "https://www.instagram.com/imdb/"
        case .xxx:
            return "https://x.com/IMDb"
        case .youtube:
            return "https://www.youtube.com/imdb"
        case .facebook:
            return "https://www.facebook.com/imdb/"
        }
    }

    public var url: URL? {
        return URL(string: self.linkString)
    }
}
