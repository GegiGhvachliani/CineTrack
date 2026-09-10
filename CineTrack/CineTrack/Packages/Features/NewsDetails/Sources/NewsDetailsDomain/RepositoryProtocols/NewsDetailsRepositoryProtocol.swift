//
//  NewsDetailsRepositoryProtocol.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

public protocol NewsDetailsRepositoryProtocol: Sendable {
    func fetchArticle() -> News
}
