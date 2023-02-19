//
//  ThemeResultViewModel.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

final class ThemeResultViewModel: ObservableObject {
    @Published var result: String?
    @Published var errorMessage: String?
    @Published var whenTextInput = ""
    @Published var whereTextInput = ""
    @Published var whoTextInput = ""
    @Published var loading = false
    @Published var isShowingAlert = false

    func generateThemes() {
        loading = true

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
                    self.loading = false
                    self.result = self.modifyThemeText(response.choices.first?.text)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.loading = false
                    switch error {
                    case .connectionError(_):
                        self.errorMessage = "ネットワーク接続に問題があります。"
                    case .responseParseError(_):
                        self.errorMessage = "予期しないエラーが発生しました"
                    case .apiError(let error):
                        self.errorMessage = error.error.message
                    }
                    self.isShowingAlert = true
                }
            }
        }
    }

    private func modifyThemeText(_ theme: String?) -> String? {
        guard let theme = theme else { return nil }
        // なぜか最初に改行文字が入っている場合があるので、取り除く
        if theme.contains("\n\n") {
            return theme.replacingOccurrences(of: "\n\n", with: "\n")
        }
        return theme
    }
}
