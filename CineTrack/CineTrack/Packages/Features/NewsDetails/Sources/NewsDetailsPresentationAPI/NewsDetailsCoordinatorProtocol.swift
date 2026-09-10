//
//  NewsDetailsCoordinatorProtocol.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import SharedCore

public protocol NewsDetailsCoordinatorProtocol: Coordinator {
    func showSource(url: URL)
}
