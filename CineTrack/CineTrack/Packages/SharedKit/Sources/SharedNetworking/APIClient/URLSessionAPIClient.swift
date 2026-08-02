//
//  URLSessionAPIClient.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public final class URLSessionAPIClient: APIClient {

    private let session: URLSession
    private let decoder: JSONDecoder

    public init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    public func sendRequest<T: Decodable>(
        _ request: APIRequest
    ) async throws -> T {

        let urlRequest = request.asURLRequest()
        print("🔍 [URL]:", urlRequest.url?.absoluteString ?? "No URL")
            print("🔑 [Auth Header]:", urlRequest.value(forHTTPHeaderField: "Authorization") ?? "No Auth Header")
        
        do {
            let (data, response) = try await session.data(
                for: urlRequest
            )

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(
                    statusCode: httpResponse.statusCode
                )
            }

            do {
                return try decoder.decode(
                    T.self,
                    from: data
                )
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch let error as NetworkError {
            throw error

        } catch {
            throw NetworkError.underlying(error)
        }
    }
}
