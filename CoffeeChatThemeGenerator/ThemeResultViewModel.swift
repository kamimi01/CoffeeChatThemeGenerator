//
//  ThemeResultViewModel.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

final class ThemeResultViewModel: ObservableObject {
    @Published var result: String?
    @Published var whenTextInput = ""
    @Published var whereTextInput = ""
    @Published var whoTextInput = ""

    func generateThemes() {
        let client = OpenAIClient()
        var request = OpenAIAPI.TextCompletion()
        var prompt: String {
            let whenPrompt = whenTextInput.isEmpty ? "" : "\(whenTextInput)に、"
            let wherePrompt = whereTextInput.isEmpty ? "" : "\(whereTextInput)で、"
            let whoPrompt = whoTextInput.isEmpty ? "" : "\(whoTextInput)と、"
            return "\(whenPrompt)\(wherePrompt)\(whoPrompt)雑談をする時に最適なテーマを1つ教えてください。できるだけ詳しくお願いします。"
        }
        request.postCompletion = PostCompletion(prompt: prompt)

        client.send(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.result = response.choices.first?.text
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.result = error.localizedDescription
                }
            }
        }
    }
}
