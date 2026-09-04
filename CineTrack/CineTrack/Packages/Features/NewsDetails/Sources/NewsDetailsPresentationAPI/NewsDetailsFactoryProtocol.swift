//
//  NewsDetailsFactoryProtocol.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol NewsDetailsFactoryProtocol {
    func makeNewsDetailsViewController(news: News) -> UIViewController
}
