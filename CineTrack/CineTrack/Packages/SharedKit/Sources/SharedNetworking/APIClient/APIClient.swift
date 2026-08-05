//
//  APIClient.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

// აბსტრაქცია: ამის მიმღებ ობიექტს უნდა შეეძლოს request-ის გაგზავნა, repostitory-ის ექნება ამ ტიპის ობიექტი, მაგრამ არა კონკრეტული ობიექტი. dependency Inversion principle, მაგ homerepository კონკრეტულად request-ის გამგზავნ კლასზე კი არ იქნება დამოკიდებული, არამედ პროტოკლზე, რომლის ტიპიც ინჯექშენით აქვს მას.

public protocol APIClient: Sendable {
    // genericFunc: არ ვიცით რა ტიპის მონაცემს დააბრუნებს API: MovieListDTO, UserDTO თუ სხვა, ამიტომ სხვადასხვასთვის რო არ ვწეროთ ერთი გვაქვვს ყველასთვის
    func sendRequest<T: Decodable>(
        _ request: APIRequest
    ) async throws -> T
}
