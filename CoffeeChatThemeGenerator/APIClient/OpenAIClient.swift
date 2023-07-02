//
//  OpenAIClient.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class OpenAIClient {
    private let client: Client

    init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthMiddleware(), CurlMiddleware()]
        )
    }

    func textCompletions(body: Components.Schemas.Completions) async throws -> Operations.completions.Output {
        let response = try await client.completions(Operations.completions.Input(
            body: .json(body)
        ))
        return response
    }
}
