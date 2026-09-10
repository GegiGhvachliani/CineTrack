//
//  SearchTarget.swift
//  Search
//

import Foundation

public enum SearchTarget: String, CaseIterable, Identifiable, Sendable {

    case movies
    case people

    public var id: Self { self }
}
