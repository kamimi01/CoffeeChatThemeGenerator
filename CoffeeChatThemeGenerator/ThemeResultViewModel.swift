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

        var prompt: String {
            let whenPrompt = whenTextInput.isEmpty ? "" : "\(whenTextInput)に、"
            let wherePrompt = whereTextInput.isEmpty ? "" : "\(whereTextInput)で、"
            let whoPrompt = whoTextInput.isEmpty ? "" : "\(whoTextInput)と、"
            return "\(whenPrompt)\(wherePrompt)\(whoPrompt)雑談をする時に最適なテーマを1つ教えてください。できるだけ詳しくお願いします。公序良俗に則った回答をしてください。"
        }

        let client = OpenAIClient()
        let body = Components.Schemas.Completions(
            model: "text-davinci-003",
            prompt: prompt,
            temperature: 0.8,
            max_tokens: 200,
            top_p: 1,
            frequency_penalty: 0.0,
            presence_penalty: 1.0
        )

        Task {
            let response = try await client.textCompletions(body: body)
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case .json(let json):
                    print(json.choices?.first?.text)
                    await MainActor.run {
                        self.loading = false
                        self.result = self.modifyThemeText(json.choices?.first?.text)
                    }
                }
            case .undocumented(statusCode: let statusCode, let payload):
                print("undocumented: \(statusCode)\n \(payload)")
                await MainActor.run {
                    self.loading = false
                    self.errorMessage = "予期しないエラーが発生しました"
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
