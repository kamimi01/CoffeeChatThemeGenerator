//
//  PostCompletion.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

struct PostCompletion {
    let model: String
    let prompt: String
    let temperature: Double
    let maxTokens: Int
    let topP: Double
    let frequencyPenalty: Double
    let presencePenalty: Double
}
