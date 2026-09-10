//
//  NetworkError.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case encodingError(Error)
    case underlying(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."

        case .invalidResponse:
            return "The server returned an invalid response."

        case let .httpError(statusCode):
            return "The server returned an HTTP error with status code \(statusCode)."

        case .decodingError:
            return "Failed to decode the server response."

        case .encodingError:
            return "Failed to encode the request body."

        case let .underlying(error):
            return error.localizedDescription
        }
    }
}
