//
//  TMDBConfiguration.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

// ინახავს TMDB-თან დაკავშირებულ configuration-ს.
public struct TMDBConfiguration: Sendable {

    public let baseURL: URL
    public let accessToken: String

    public init(
        baseURL: URL,
        accessToken: String
    ) {
        self.baseURL = baseURL
        self.accessToken = accessToken
    }
}

// MARK: მაგალითად
/* let configuration = TMDBConfiguration(
 baseURL: URL(
     string: "https://api.themoviedb.org"
 )!,
 accessToken: "..."
)*/

// MARK: რატომ არ ვწერთ ამას პირდაპირ TMDBRequestBuilder-ში?
// შეგვეძლო მაგრამ მაშინ configuration hardcoded გვექნებოდა
/*
 private let baseURL =
     URL(string: "https://api.themoviedb.org")!

 private let accessToken = "..."
 */

// ამიტომ builder-ს configuration გარედან მიეწოდება. რაც ნიშნავს რომ შეგვიძლია მივაწოდოთ მას სხვადასხვა კონფიგურაციები
/*Development
 ↓
TMDB Dev Configuration

Production
 ↓
TMDB Production Configuration*/

// ან საერთოდ mock configuration, რადგან გვაქვს def inj
