public enum MovieDetailsStrings {

    // MARK: - Screen Content

    public enum Content {
        public static let actor = "Actor"
        public static let allCast = "All Cast"
        public static let moreLikeThis = "More Like This"
        public static let images = "Images"
        public static let relatedNews = "Related News"
        public static let seeAll = "See All"
        public static let addedToWatchlist = " Added to Watchlist"
        public static let addToWatchlist = " Add to Watchlist"
        public static let unableToLoadMovie = "Unable to load movie"
        public static let pleaseTryAgain = "Please try again."
        public static let tryAgain = "Try Again"
    }

    // MARK: - Formatted Text

    public enum Format {
        public static func moreFrom(actorName: String) -> String { "More From \(actorName)" }
        public static func runtime(minutes: Int) -> String { "\(minutes) min" }
        public static func play(name: String) -> String { "Play \(name)" }
    }
}
