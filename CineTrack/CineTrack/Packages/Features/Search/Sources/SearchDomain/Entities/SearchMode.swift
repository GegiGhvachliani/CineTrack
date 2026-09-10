//
//  SearchMode.swift
//  Search
//

import Foundation

public enum SearchMode: String, CaseIterable, Identifiable, Sendable {

    case recent
    case advanced

    public var id: Self { self }
}
