//
//  MovieVideoDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import Foundation

public struct MovieVideoDTO: Decodable {

    // MARK: - Properties

    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let type: String
    public let official: Bool
}
