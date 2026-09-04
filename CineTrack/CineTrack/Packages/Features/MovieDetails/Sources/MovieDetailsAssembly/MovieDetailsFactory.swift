//
//  MovieDetailsFactory.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SwiftUI

import SharedCore
import MovieDetailsPresentation
import MovieDetailsPresentationAPI

@MainActor
public struct MovieDetailsFactory: MovieDetailsFactoryProtocol {

    public init() {}

    public func makeMovieDetailsViewController(movie: Movie) -> UIViewController {
        let view = MovieDetailsView(movie: movie)

        return UIHostingController(rootView: view)
    }
}
