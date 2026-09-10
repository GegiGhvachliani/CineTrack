//
//  NewsDetailsViewModelProtocol.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import Observation

import SharedCore

@MainActor
public protocol NewsDetailsViewModelProtocol: AnyObject, Observable {

    // MARK: - Content

    var news: News { get }
    var metadata: String { get }
    var sourceName: String { get }
    var articleURL: URL? { get }

    // MARK: - Actions

    func didTapSource()
}
