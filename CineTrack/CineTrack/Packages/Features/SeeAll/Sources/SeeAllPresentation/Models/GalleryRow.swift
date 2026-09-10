//
//  GalleryRow.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct GalleryRow: Identifiable {

    // MARK: - Properties

    let images: [GalleryImage]

    var id: String {
        images.map(\.id).joined(separator: "-")
    }
}
