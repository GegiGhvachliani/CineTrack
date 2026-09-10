//
//  TextSearchRequest.swift
//  Search
//

import Foundation
import SearchDomain

struct TextSearchRequest: Equatable {

    // MARK: - Properties

    let query: String
    let target: SearchTarget
    let generation: UUID
}
