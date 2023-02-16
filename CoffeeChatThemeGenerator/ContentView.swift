//
//  ContentView.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ThemeResultViewModel()
    @State private var whenTextInput = ""
    @State private var whereTextInput = ""
    @State private var whoTextInput = ""

    var body: some View {
        ZStack {
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                whenTextField
                whereTextField
                whoTextField
                submitButton
            }
            .padding(40)
        }
    }
}

private extension ContentView {
    var whenTextField: some View {
        VStack {
            TextField("夜", text: $whenTextInput)
                .padding()
                .frame(height: 50, alignment: .top)
                .background(Color.smokeWhite)
                .cornerRadius(20)
            Text("に")
                .font(.title)
                .foregroundColor(.smokeWhite)
        }
    }

    var whereTextField: some View {
        VStack {
            TextField("東京のバー", text: $whereTextInput)
                .padding()
                .frame(height: 50, alignment: .top)
                .background(Color.smokeWhite)
                .cornerRadius(20)
            Text("で")
                .font(.title)
                .foregroundColor(.smokeWhite)
        }
    }

    var whoTextField: some View {
        VStack {
            TextField("昔から仲のいい友人", text: $whoTextInput)
                .padding()
                .frame(height: 50, alignment: .top)
                .background(Color.smokeWhite)
                .cornerRadius(20)
            Text("と")
                .font(.title)
                .foregroundColor(.smokeWhite)
        }
    }

    var submitButton: some View {
        Button(action: {
            viewModel.generateThemes()
        }) {
            Text("話したい時にベストなテーマは？")
                .foregroundColor(.smokeBlack)
                .padding()
                .frame(height: 50, alignment: .top)
                .background(Color.smokeWhite)
                .cornerRadius(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
