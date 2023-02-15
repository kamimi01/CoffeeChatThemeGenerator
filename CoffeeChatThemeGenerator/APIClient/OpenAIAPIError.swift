//
//  OpenAIAPIError.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

struct OpenAIAPIError: Decodable, Error {
    let error: ErrorSummary
}

struct ErrorSummary: Decodable, Error {
    let message: String
    let type: String
}
