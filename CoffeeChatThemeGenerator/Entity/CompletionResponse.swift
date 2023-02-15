//
//  CompletionResponse.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

struct CompletionResponse: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let text: String
}
