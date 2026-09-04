//
//  SeeAllFactory.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SeeAllPresentation
import SeeAllPresentationAPI
import SharedCore

@MainActor
public struct SeeAllFactory: SeeAllFactoryProtocol {

    public init() {}

    public func makeSeeAllViewController(section: HomeSection) -> UIViewController {
        let view = SeeAllView(section: section)

        return UIHostingController(rootView: view)
    }
}
