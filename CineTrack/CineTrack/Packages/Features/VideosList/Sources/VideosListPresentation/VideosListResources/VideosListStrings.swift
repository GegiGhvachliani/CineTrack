//
//  VideosListStrings.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

public enum VideosListStrings {

    // MARK: - Screen Content

    public enum Content {
        public static let watchOnYouTube = "Watch on YouTube"
        public static let videoUnavailable = "Video unavailable"
        public static let playlistUnavailable = "We couldn't load this playlist."
        public static let nowPlaying = "NOW PLAYING"
        public static let playlist = "PLAYLIST"
    }

    // MARK: - Formatted Text

    public enum Format {
        public static func playbackError(code: Int) -> String {
            "This video couldn't be played here. Try opening it on YouTube. (\(code))"
        }
    }
}
