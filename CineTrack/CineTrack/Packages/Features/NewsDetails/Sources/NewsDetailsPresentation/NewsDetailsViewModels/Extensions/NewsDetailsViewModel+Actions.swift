//
//  NewsDetailsViewModel+Actions.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import Observation
import NewsDetailsDomain
import SharedCore

extension NewsDetailsViewModel {

    // MARK: - Actions

    public func didTapSource() {
        guard let articleURL else {
            return
        }

        onOpenSource?(articleURL)
    }
}
