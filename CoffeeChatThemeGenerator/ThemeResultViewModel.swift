//
//  ThemeResultViewModel.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/15.
//

import Foundation

final class ThemeResultViewModel: ObservableObject {
    @Published var result: String?

    func onAppear() {
        let client = OpenAIClient()
        let request = OpenAIAPI.TextCompletion()
        

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
