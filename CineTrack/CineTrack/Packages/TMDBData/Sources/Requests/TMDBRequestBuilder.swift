//
//  TMDBRequestBuilder.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedNetworking

// MARK: მთავარი პასუხისმგებლობაა EndPoint-ისგან ააწყოს APIRequest
/* TMDBEndpoint
 ↓
TMDBRequestBuilder
 ↓
APIRequest*/

// MARK: მაგ
/*
 let endpoint = TMDBEndpoint.popular
 
 let request = requestBuilder.build(
     for: endpoint
 )
 */

public struct TMDBRequestBuilder: Sendable {

    private let configuration: TMDBConfiguration // რომელიმე ენდფოინთის კონფიგურაცია DI-ით.

    public init(configuration: TMDBConfiguration) {
        self.configuration = configuration
    }

    public func build(for endpoint: TMDBEndpoint) throws -> APIRequest {
        
        var components = URLComponents(url: configuration.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )
        
        if let page = endpoint.page {
            components?.queryItems = [
                URLQueryItem(
                    name: "page",
                    value: String(page)
                )
            ]
        }
        
        // configuratoin.baseURL არის https://api.themoviedb.org
        // თუ endpoint არის მაგალითად .popular (ანუ /3/movie/popular) მივიღებთ: https://api.themoviedb.org/3/movie/popular
        
        // MARK: რატომ URLComponents და არა ჩვეულებრივი ინტერპოლაცია?
        //იმიტომ რომ URL მხოლოდ path არ არის. მას შეიძლება ჰქონდეს: Scheme, Host, Path, Query
        /*
         https://api.themoviedb.org/3/movie/popular?page=2
         │      │                  │                  │
         │      │                  │                  └ Query
         │      │                  └ Path
         │      └ Host
         └ Scheme
         */
        
        // URLComponents გვაძლევს საშუალებას ეს ნაწილები უსაფრთხოდ ავაწყოთ
        
        // MARK: რატომ არ ვაკეთებთ String ინტერპოლაციას?
        // შეგვეძლო:
        //
        /*
         let url = "\(baseURL)/3/movie/popular?page=\(page)"
         */
        // მაგრამ ეს ნაკლებად უსაფრთხო და მოქნილია.
        // URLComponents და URLQueryItem აკეთებენ URL-ის სწორ encoding-ს. ამიტომ ეს უფრო სწორი მიდგომაა
        
    // MARK: _________________________________________________________________________

        
        // შეიძლება რომ ჩვენი URL ვალიდური ვერ შეიქმნას, ამიტომ:
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        /*
         URLComponents
         ↓
         URL?
         ↓
         guard
         ↓
         Valid URL
         */

        // TMDB-specific ინფორმაცია ერთიანდება generic APIRequest-ში.
        return APIRequest(
            url: url,
            method: endpoint.method,
            headers: [
                "Authorization": "Bearer \(configuration.accessToken)",
                "Accept": "application/json"
            ]
        )
    }
}
