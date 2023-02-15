//
//  OpenAIClientError.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

enum OpenAIClientError: Error {
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(OpenAIAPIError)
}
