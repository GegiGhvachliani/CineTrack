//
//  APIRequest.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

// MARK: სტრუქტურა, რომელიც ამზადებს request-ს გასაზამზადებლად

import Foundation

public struct APIRequest {

    public let url: URL
    public let method: HTTPMethod
    public let headers: [String: String]
    public let body: Data?

    public init(
        url: URL,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }

    // MARK: მეთოდი, რომელიც მონაცემებს გარდაქმნის Apple-ის მშობლიურ URLRequest ობიექტად. შემდეგ კი URLSession იზრუნებს ამის გაგზავნაზე. ანუ APIRequest გადაიქცევა URLRequest
    public func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url) // ქმნის ცარიელ ოფიციალურ ფორმას და უწერს მისამართს.

        request.httpMethod = method.rawValue // ანიჭებს მოთხოვნის ტიპს (მაგ: "GET")
        request.httpBody = body // თუ request-ს აქვს body, მას ვამატებთ მაგალითად პოსტ რექუესთზე
//        POST /users
        
//    Body:
//    {
//        "name": "Gegi"
//    }
        // ჩემს TMDB GET request-ებში body არ გვაქვს, ამიტომ body == nil

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
//      თუ მაქვს:
//        [
//            "Authorization": "Bearer token",
//            "Accept": "application/json"
//        ]
//
//        იქმნება HTTP headers:
//
//        Authorization: Bearer token
//        Accept: application/json
//
        return request
    }
}
