//
//  OpenAITextCompletionAPI.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

final class OpenAIAPI {
    struct TextCompletion: OpenAIRequest {
        typealias Response = CompletionResponse
        var postCompletion: PostCompletion?

        var method: HTTPMethod {
            return .post
        }

        var path: String {
            return "/completions"
        }

        var body: Data? {
            guard let postCompletion = postCompletion else {
                return nil
            }
            let body: [String: Any] = [
                "model": postCompletion.model,
                "prompt": postCompletion.prompt,
                "temperature": postCompletion.temperature,
                "max_tokens": postCompletion.maxTokens,
                "top_p": postCompletion.topP,
                "frequency_penalty": postCompletion.frequencyPenalty,
                "presence_penalty": postCompletion.presencePenalty
            ]
            return try! JSONSerialization.data(withJSONObject: body, options: [])
        }
    }
}
