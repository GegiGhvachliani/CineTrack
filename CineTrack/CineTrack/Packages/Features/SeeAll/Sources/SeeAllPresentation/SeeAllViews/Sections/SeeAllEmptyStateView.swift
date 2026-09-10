//
//  SeeAllEmptyStateView.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct SeeAllEmptyStateView: View {

    // MARK: - Properties

    let isEmpty: Bool

    // MARK: - Body

    var body: some View {
        if isEmpty {
            ContentUnavailableView(SeeAllStrings.Content.nothingToShow, systemImage: "tray")
        }
    }
}
