//
//  MovieDetailsRepositoryProtocol.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

public protocol MovieDetailsRepositoryProtocol: Sendable {
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetails
    func fetchCast(movieID: Int) async throws -> [MovieCastMember]
    func fetchVideos(movieID: Int) async throws -> [MovieVideo]
    func fetchImages(movieID: Int) async throws -> [MovieImage]
    func fetchSimilarMovies(movieID: Int, page: Int) async throws -> SimilarMoviesPage
    func fetchMovies(for actorID: Int) async throws -> [Movie]
    func fetchNews(movieTitle: String, page: Int) async throws -> NewsPage
}
