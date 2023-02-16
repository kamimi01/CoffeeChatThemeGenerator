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
            // TODO: postCompletion の値を使うように修正
//            let body: [String: Any] = [
//                "model": "text-davinci-003",
//                "prompt": "初めて会う人とカフェでお昼に雑談をするために必要なテーマを3つ教えてください。できるだけ詳しくお願いします",
//                "temperature": 0.8,
//                "max_tokens": 200,
//                "top_p": 1.0,
//                "frequency_penalty": 0.0,
//                "presence_penalty": 1.0
//            ]
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
