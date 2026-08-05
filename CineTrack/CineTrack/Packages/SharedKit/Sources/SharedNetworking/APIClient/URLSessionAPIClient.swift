//
//  URLSessionAPIClient.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
// APIClient-ის კონკრეტული იმპლემენტაცია
// URLRequest არის ობიექტი სადაც აღწერილია რა მოთხოვნაც უნდა გაიგზავნოს
// URLSession არის ობიექტი სადაც აღწერილია როგორ უნდა გაიგზავნოს
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
        
        let urlRequest = request.asURLRequest() // APIRequest-ის ფუქნცია, რაც ჩვენი მონაცემს გარდაქმნის რეალურ URLRequest-ად.
        print("🔍 [URL]:", urlRequest.url?.absoluteString ?? "No URL")
        print("🔑 [Auth Header]:", urlRequest.value(forHTTPHeaderField: "Authorization") ?? "No Auth Header")
        
        do {
            // იგზავნება რექუესთი
            // აბრუნდებს ორ რამეს data(JSON bytes) და response(HTTP response metadata(მაგალითან Status Code: 200))
            let (data, response) = try await session.data(
                for: urlRequest
            )
            
            // URLSession-ს აქვს ზოგადი URLResponse პასუხი, მაგრამ ჩვენ გვჭირდება კონკრეტულად HTTPURLResponse რომ ამოვიღოთ HTTPURLResponse.statusCode ინფორმაცია (200, 201, 401, 404...). ამიტომ თუ response არ არის HTTP response ვისვრით invalidResponse errors-ს
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            // მარტო საქსესი გვინდა თუ არა ისვრის statuscode-ის ერორს. კონკრეტული ერორით ვიგებთ პრობლემის მიზეზს მაგალითად 401-ზე ვიცით რომ Server-მა request მიიღო, მაგრამ authorization პრობლემა გვაქვს.
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(
                    statusCode: httpResponse.statusCode
                )
            }
            
            // თუ HTTP status წარმატებულია
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


// MARK: საბოლოოდ ხდება ასე

/*HTTPMethod
 │
 │  აღწერს HTTP ოპერაციას
 ↓
APIRequest
 │
 │  აღწერს რა request უნდა გავგზავნოთ
 ↓
APIClient
 │
 │  განსაზღვრავს კონტრაქტს
 ↓
URLSessionAPIClient
 │
 │  რეალურად აგზავნის request-ს
 ↓
URLSession
 │
 │  ინტერნეტთან კომუნიკაცია
 ↓
HTTP Response
 │
 ├── Error → NetworkError
 │
 └── Success
        ↓
    JSONDecoder
        ↓
    Decodable T*/
