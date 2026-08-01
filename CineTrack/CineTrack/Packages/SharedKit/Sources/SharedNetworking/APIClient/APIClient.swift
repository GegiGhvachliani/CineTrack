//
//  APIClient.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public protocol APIClient {
    func sendRequest<T: Decodable>(
        _ request: APIRequest
    ) async throws -> T
}
