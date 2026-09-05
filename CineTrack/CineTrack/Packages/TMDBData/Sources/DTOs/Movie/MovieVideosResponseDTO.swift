//
//  MovieVideosResponseDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import Foundation

public struct MovieVideosResponseDTO: Decodable {
    
    public let id: Int
    public let results: [MovieVideoDTO]
}
