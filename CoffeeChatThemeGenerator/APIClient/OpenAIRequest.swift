//
//  OpenAIRequest.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

protocol OpenAIRequest {
    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

extension OpenAIRequest {
    var baseURL: URL {
        return URL(string: "https://api.openai.com/v1")!
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(openAIAPIKey)"
        ]
    }

    /// URLRequestを作成する
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        if let body = body {
            urlRequest.httpBody = body
        }
        headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }

    /// URLResponse を 扱いたい型に変換する
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()

        if case(200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            return try decoder.decode(Response.self, from: data)
        } else {
            throw try decoder.decode(OpenAIAPIError.self, from: data)
        }
    }
}
