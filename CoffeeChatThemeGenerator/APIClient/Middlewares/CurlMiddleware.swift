//
//  ExportCurlMiddleware.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/07/02.
//

import Foundation
import OpenAPIRuntime

final class CurlMiddleware: ClientMiddleware {
    func intercept(_ request: Request, baseURL: URL, operationID: String, next: (Request, URL) async throws -> Response) async throws -> Response {
        var baseCommand = ""
        if let query = request.query {
            baseCommand = #"curl "\#(baseURL.absoluteString)\#(request.path)"?\#(query)""#
        } else {
            baseCommand = #"curl "\#(baseURL.absoluteString)\#(request.path)""#
        }

        if request.method == .head {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if request.method != .get && request.method != .head {
            command.append("-X \(request.method.rawValue)")
        }

        for field in request.headerFields {
            if field.name != "Cookie" {
                command.append("-H '\(field.name): \(field.value)'")
            }
        }

        if let data = request.body, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        print(command.joined(separator: " \\\n\t"))

        return try await next(request, baseURL)
    }
}
