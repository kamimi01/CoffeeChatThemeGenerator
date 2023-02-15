//
//  ContentView.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ThemeResultViewModel()

    var body: some View {
        VStack {
            Button(action: {
                viewModel.onAppear()
            }) {
                Text("OpenAI Text Completion")
            }
            Text(viewModel.result ?? "")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
