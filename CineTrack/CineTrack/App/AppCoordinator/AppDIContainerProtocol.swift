//
//  AppDIContainerProtocol.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import Foundation
import HomePresentationAPI
import ProfilePresentationAPI
import SearchPresentationAPI

@MainActor
protocol AppDIContainerProtocol {
    var homeFactory: HomeFactoryProtocol { get }
    var profileFactory: ProfileFactoryProtocol { get }
    var searchFactory: SearchFactoryProtocol { get }
}
