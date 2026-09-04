//
//  MovieDetailsFactoryProtocol.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol MovieDetailsFactoryProtocol {
    func makeMovieDetailsViewController(movie: Movie) -> UIViewController
}
