//
//  OpenAIClient.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

final class OpenAIClient {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()

    func send<Request: OpenAIRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, OpenAIClientError>) -> Void
    ){
        let urlRequest = request.buildURLRequest()

        let task = session.dataTask(with: urlRequest) { data, response, error in
            switch (data, response, error) {
            case (_, _, let error?):
                completion(.failure(.connectionError(error)))
            case (let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(.success(response))
                } catch let error as OpenAIAPIError {
                    completion(.failure(.apiError(error)))
                } catch {
                    completion(.failure(.responseParseError(error)))
                }
            default:
                fatalError("invalid response combination: \(data), \(response), \(error)")
            }
        }
        task.resume()
    }
}
