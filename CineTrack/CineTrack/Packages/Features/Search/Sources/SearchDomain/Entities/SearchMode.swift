//
//  SearchMode.swift
//  Search
//

import Foundation

public enum SearchMode: String, CaseIterable, Identifiable, Sendable {

    case recent = "Recent"
    case advanced = "Advanced"

    public var id: Self { self }
}
