//
//  HomeRepositoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public protocol HomeRepositoryProtocol: Sendable {

    func fetchTrending(page: Int) async throws -> MoviePage

    func fetchPopular(page: Int) async throws -> MoviePage

    func fetchTopRated(page: Int) async throws -> MoviePage

    func fetchNowPlaying(page: Int) async throws -> MoviePage

    func fetchUpcoming(page: Int) async throws -> MoviePage
}
