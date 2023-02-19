//
//  ContentView.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ThemeResultViewModel()
    @FocusState private var isFocusedWhen: Bool
    @FocusState private var isFocusedWhere: Bool
    @FocusState private var isFocusedWho: Bool

    var body: some View {
        ZStack {
            Color.smokeWhite
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                ZStack {
                    VStack {
                        Spacer()
                            .frame(height: 200)
                        Color.mainBackground
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                isFocusedWhen = false
                                isFocusedWhere = false
                                isFocusedWho = false
                            }
                    }
                    VStack(spacing: 25) {
                        LottieView(animationType: .friends)
                            .frame(height: 200)
                        whenTextField
                        whereTextField
                        whoTextField
                        submitButton
                        Spacer()
                    }
                    .padding(40)
                }
            }
        }
    }
}

private extension ContentView {
    var whenTextField: some View {
        VStack {
            ZStack {
                TextField("", text: $viewModel.whenTextInput, axis: .vertical)
                    .padding()
                    .foregroundColor(.smokeBlack)
                    .accentColor(.mainBackground)
                    .font(.system(size: 18))
                    .frame(height: 60, alignment: .top)
                    .background(Color.smokeWhite)
                    .cornerRadius(30)
                    .focused($isFocusedWhen)
                    .onTapGesture {
                        isFocusedWhen = true
                    }
                    .shadow(color: .smokeBlack, radius: 2, x: 0, y: 1)
                if viewModel.whenTextInput.isEmpty {
                    whenTextFieldPlaceHolder
                }
            }
            Text("に")
                .font(.title2)
                .foregroundColor(.smokeWhite)
        }
    }

    var whenTextFieldPlaceHolder: some View {
        HStack(spacing: 10) {
            Image(systemName: "timer")
                .resizable()
                .frame(width: 25, height: 25)
            Text("例）夜")
                .font(.system(size: 18))
            Spacer()
        }
        .foregroundColor(.gray)
        .padding()
        .padding([.leading], 5)
    }

    var whereTextField: some View {
        VStack {
            ZStack {
                TextField("", text: $viewModel.whereTextInput, axis: .vertical)
                    .padding()
                    .foregroundColor(.smokeBlack)
                    .accentColor(.mainBackground)
                    .font(.system(size: 18))
                    .frame(height: 60, alignment: .top)
                    .background(Color.smokeWhite)
                    .cornerRadius(30)
                    .focused($isFocusedWhere)
                    .onTapGesture {
                        isFocusedWhere = true
                    }
                    .shadow(color: .smokeBlack, radius: 2, x: 0, y: 1)
                if viewModel.whereTextInput.isEmpty {
                    whereTextFieldPlaceHolder
                }
            }
            Text("で")
                .font(.title2)
                .foregroundColor(.smokeWhite)
        }
    }

    var whereTextFieldPlaceHolder: some View {
        HStack(spacing: 10) {
            Image(systemName: "location.north.fill")
                .resizable()
                .frame(width: 25, height: 25)
            Text("例）東京のバー")
                .font(.system(size: 18))
            Spacer()
        }
        .foregroundColor(.gray)
        .padding()
        .padding([.leading], 5)
    }

    var whoTextField: some View {
        VStack {
            ZStack {
                TextField("", text: $viewModel.whoTextInput, axis: .vertical)
                    .padding()
                    .foregroundColor(.smokeBlack)
                    .accentColor(.mainBackground)
                    .font(.system(size: 18))
                    .frame(height: 60, alignment: .top)
                    .background(Color.smokeWhite)
                    .cornerRadius(30)
                    .focused($isFocusedWho)
                    .onTapGesture {
                        isFocusedWho = true
                    }
                    .shadow(color: .smokeBlack, radius: 2, x: 0, y: 1)
                if viewModel.whoTextInput.isEmpty
                {
                    whoTextFieldPlaceHolder
                }
            }
            Text("と")
                .font(.title2)
                .foregroundColor(.smokeWhite)
        }
    }

    var whoTextFieldPlaceHolder: some View {
        HStack(spacing: 10) {
            Image(systemName: "person")
                .resizable()
                .frame(width: 25, height: 25)
            Text("例）仲のいい友達")
                .font(.system(size: 18))
            Spacer()
        }
        .foregroundColor(.gray)
        .padding()
        .padding([.leading], 5)
    }

    var submitButton: some View {
        Button(action: {
            viewModel.generateThemes()
        }) {
            Text("話すときのテーマは？")
                .foregroundColor(.smokeWhite)
                .bold()
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 60, alignment: .top)
                .background(Color.mainBackground)
                .cornerRadius(30)
        }
        .shadow(color: .smokeBlack, radius: 2, x: 0, y: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
