//
//  MovieDetailsScrollOffsetKey.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

struct MovieDetailsScrollOffsetKey: PreferenceKey {

    // MARK: - Properties

    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
