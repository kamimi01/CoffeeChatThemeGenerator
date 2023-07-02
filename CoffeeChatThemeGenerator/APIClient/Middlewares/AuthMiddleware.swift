//
//  AuthMiddleware.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/07/02.
//

import Foundation
import OpenAPIRuntime

final class AuthMiddleware: ClientMiddleware {
    func intercept(_ request: Request, baseURL: URL, operationID: String, next: (Request, URL) async throws -> Response) async throws -> Response {
        var request = request
        request.headerFields.append(.init(
            name: "Authorization", value: "Bearer \(openAIAPIKey)")
        )
        request.headerFields.append(.init(
            name: "Content-Type", value: "application/json")
        )
        return try await next(request, baseURL)
    }
}
