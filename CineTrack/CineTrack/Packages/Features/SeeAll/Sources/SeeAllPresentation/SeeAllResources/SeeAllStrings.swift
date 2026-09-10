//
//  SeeAllStrings.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

public enum SeeAllStrings {

    // MARK: - Screen Content

    public enum Content {
        public static let news = "News"
        public static let done = "Done"
        public static let nothingToShow = "Nothing to show"
    }

    // MARK: - Formatted Text

    public enum Format {
        public static func age(years: Int) -> String { "\(years) years old" }
    }
}
