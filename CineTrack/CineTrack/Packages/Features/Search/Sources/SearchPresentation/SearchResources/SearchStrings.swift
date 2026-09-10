//
//  SearchStrings.swift
//  Search
//

public enum SearchStrings {

    // MARK: - Screen Content

    public enum Content {
        public static let cineTrackRating = "CineTrack Rating"
        public static let recent = "Recent"
        public static let advanced = "Advanced"
        public static let movie = "Movie"
        public static let actor = "Actor"
        public static let noResults = "No results"
        public static let tryAnotherSearchOrAdjustTheFilters = "Try another search or adjust the filters."
        public static let startExploring = "Start exploring"
        public static let searchForAMovieOrAnActor = "Search for a movie or an actor."
        public static let chooseFiltersThenSeeYourResults = "Choose filters, then see your results."
        public static let resetOptions = "Reset options"
        public static let totalVotes = "Total Votes"
        public static let genres = "Genres"
        public static let releaseYear = "Release Year"
        public static let runtime = "Runtime"
        public static let productionRegion = "Production Region"
        public static let any = "Any"
        public static let action = "Action"
        public static let adventure = "Adventure"
        public static let animation = "Animation"
        public static let comedy = "Comedy"
        public static let crime = "Crime"
        public static let documentary = "Documentary"
        public static let drama = "Drama"
        public static let family = "Family"
        public static let fantasy = "Fantasy"
        public static let history = "History"
        public static let horror = "Horror"
        public static let music = "Music"
        public static let mystery = "Mystery"
        public static let romance = "Romance"
        public static let scienceFiction = "Science Fiction"
        public static let tvMovie = "TV Movie"
        public static let thriller = "Thriller"
        public static let war = "War"
        public static let western = "Western"
        public static let unitedStates = "United States"
        public static let india = "India"
        public static let unitedKingdom = "United Kingdom"
        public static let france = "France"
        public static let japan = "Japan"
        public static let southKorea = "South Korea"
        public static let germany = "Germany"
        public static let italy = "Italy"
        public static let spain = "Spain"
        public static let china = "China"
        public static let canada = "Canada"
        public static let australia = "Australia"
        public static let mexico = "Mexico"
        public static let brazil = "Brazil"
        public static let russia = "Russia"
        public static let hongKong = "Hong Kong"
        public static let sweden = "Sweden"
        public static let denmark = "Denmark"
        public static let norway = "Norway"
        public static let netherlands = "Netherlands"
        public static let belgium = "Belgium"
        public static let switzerland = "Switzerland"
        public static let austria = "Austria"
        public static let ireland = "Ireland"
        public static let newZealand = "New Zealand"
        public static let argentina = "Argentina"
        public static let turkey = "Turkey"
        public static let thailand = "Thailand"
        public static let indonesia = "Indonesia"
        public static let philippines = "Philippines"
        public static let searchMovies = "Search movies"
        public static let searchActors = "Search actors"
        public static let seeResults = "See Results"
        public static let from = "From"
        public static let upperBound = "To"
        public static let resultsUnavailable = "We couldn't load results. Please try again."
    }

    // MARK: - Formatted Text

    public enum Format {
        public static func rangeValue(title: String, value: String) -> String { "\(title): \(value)" }
        public static func votes(count: Int) -> String { "\(count.formatted())+ votes" }
        public static func runtime(minutes: Int) -> String { "\(minutes) min" }
    }
}
