//
//  ActorCreditMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

import TMDBData
import ActorDetailsDomain

public struct ActorCreditMapper: Sendable {

    // MARK: - Properties

    private let imageBaseURL = "https://image.tmdb.org/t/p/w780"

    // MARK: - Initialization

    public init() {}

    public func map(
        _ dto: ActorCreditDTO
    ) -> ActorCredit {
        ActorCredit(
            id: dto.id,
            creditID: dto.creditID,
            title: dto.title,
            overview: dto.overview ?? "",
            posterPath: dto.posterPath,
            backdropPath: dto.backdropPath,
            posterURL: makeImageURL(from: dto.posterPath),
            backdropURL: makeImageURL(from: dto.backdropPath),
            releaseDate: dto.releaseDate,
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount,
            character: dto.character,
            department: dto.department,
            job: dto.job,
            order: dto.order
        )
    }

    private func makeImageURL(from path: String?) -> URL? {
        guard let path, !path.isEmpty else {
            return nil
        }

        if path.hasPrefix("http") {
            return URL(string: path)
        }

        return URL(
            string: "\(imageBaseURL)\(path)"
        )
    }
}
