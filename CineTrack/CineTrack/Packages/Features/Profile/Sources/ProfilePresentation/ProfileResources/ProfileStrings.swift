public enum ProfileStrings {

    // MARK: - Screen Content

    public enum Content {
        public static let invalidPhoto = "This photo couldn't be opened. Please choose another image."
        public static let recentlyViewed = "Recently Viewed"
        public static let favourited = "Favourited"
        public static let watchlisted = "Watchlisted"
        public static let changeProfilePhoto = "Change profile photo"
        public static let signingOut = "Signing Out…"
        public static let signOut = "Sign Out"
        public static let yourAccount = "Your account"
        public static let tryAgain = "Try Again"
        public static let somethingWentWrong = "Something went wrong"
        public static let okay = "OK"
        public static let yourFavouritePeopleWillAppearHere = "Your favourite people will appear here."
        public static let tapTheHeartOnAPersonsCardTo =
            "Tap the heart on a person's card to add them to your favourites."
        public static let seeAll = "See All"
        public static let yourWatchlistIsWaitingForItsFirstMovie = "Your watchlist is waiting for its first movie."
        public static let tapTheBookmarkOnAMovieToSave = "Tap the bookmark on a movie to save it for later."
    }

    // MARK: - Formatted Text

    public enum Format {
        public static func joined(date: String) -> String { "Joined \(date)" }
    }
}
