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

    init(model: String = "text-davinci-003", prompt: String, temperature: Double = 0.8, maxTokens: Int = 200, topP: Double = 1.0, frequencyPenalty: Double = 0.0, presencePenalty: Double = 1.0) {
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.maxTokens = maxTokens
        self.topP = topP
        self.frequencyPenalty = frequencyPenalty
        self.presencePenalty = presencePenalty
    }
}
