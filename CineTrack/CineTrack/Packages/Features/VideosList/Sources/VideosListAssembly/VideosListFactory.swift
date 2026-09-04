//
//  VideosListFactory.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SharedCore
import VideosListPresentation
import VideosListPresentationAPI

@MainActor
public struct VideosListFactory: VideosListFactoryProtocol {

    public init() {}

    public func makeVideosListViewController(item: FeaturedItem) -> UIViewController {
        let view = VideosListView(item: item)

        return UIHostingController(rootView: view)
    }
}
