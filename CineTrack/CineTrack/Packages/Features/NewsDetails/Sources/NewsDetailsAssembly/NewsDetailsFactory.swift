//
//  NewsDetailsFNewsy.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SharedCore
import NewsDetailsPresentation
import NewsDetailsPresentationAPI

@MainActor
public struct NewsDetailsFactory: NewsDetailsFactoryProtocol {

    public init() {}

    public func makeNewsDetailsViewController(news: News) -> UIViewController {
        let view = NewsDetailsView(news: news)
        return UIHostingController(rootView: view)
    }
}
