public enum ActorDetailsStrings {

    // MARK: - Screen Content

    public enum Content {
        public static let website = "Website"
        public static let filmography = "Filmography"
        public static let images = "Images"
        public static let relatedNews = "Related News"
        public static let seeAll = "See All"
        public static let facebook = "Facebook"
        public static let instagram = "Instagram"
        public static let xPlatform = "X"
        public static let imdb = "IMDb"
        public static let addedToFavorites = "  Added to Favorites"
        public static let addToFavorites = "  Add to Favorites"
        public static let unableToLoadActor = "Unable to load actor"
        public static let pleaseTryAgain = "Please try again."
        public static let tryAgain = "Try Again"
        public static let tikTok = "TikTok"
        public static let youTube = "YouTube"
        public static let wikiData = "WikiData"
    }

    // MARK: - Formatted Text

    public enum Format {
        public static func noBiography(name: String) -> String { "No biography is available for \(name)." }
        public static func miniBiography(name: String) -> String { "Mini Biography: \(name)" }
        public static func biographyNotFound(name: String) -> String { "\(name) biography not found" }
        public static func born(date: String) -> String { "Born: \(date)" }
        public static func aged(age: Int) -> String { " (aged \(age))" }
        public static func died(date: String, age: String) -> String { "Died: \(date)\(age)" }
    }
}
