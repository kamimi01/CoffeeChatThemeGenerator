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
    @State private var isShowingResult = false
    @State private var isShowingAppInfoScreen = false

    var body: some View {
        ZStack {
            Color.smokeWhite
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                ScrollViewReader { reader in
                    ScrollView {
                        ZStack {
                            VStack {
                                Spacer()
                                    .frame(height: 220)
                                    .id("screen_top")
                                Color.mainBackground
                                    .edgesIgnoringSafeArea(.all)
                                    .onTapGesture {
                                        isFocusedWhen = false
                                        isFocusedWhere = false
                                        isFocusedWho = false
                                    }
                            }
                            VStack(spacing: 0) {
                                LottieView(animationType: .friends)
                                    .frame(height: 240)
                                VStack(spacing: 45) {
                                    VStack(spacing: 25) {
                                        whenTextField
                                        whereTextField
                                        whoTextField
                                    }
                                    VStack {
                                        NavigationLink(
                                            destination: ThemeResultScreen(theme: viewModel.result ?? "ç”æăȘă"),
                                            isActive: $isShowingResult
                                        ) {
                                            EmptyView()
                                        }
                                        submitButton(proxy: reader)
                                            .padding(.bottom, 50)
                                    }
                                    .onChange(of: viewModel.result) { _ in
                                        if let result = viewModel.result {
                                            if !result.isEmpty {
                                                isShowingResult = true
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(40)
                        }
                    }
                    .navigationTitle("ăăŒăăă€ăă")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            appInfoButton
                        }
                    }
                }
            }
            .onChange(of: viewModel.loading) { loading in
                if loading {
                    isFocusedWhen = false
                    isFocusedWhere = false
                    isFocusedWho = false
                }
            }
            if viewModel.loading {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .scaleEffect(x: 2, y: 2, anchor: .center)
                    .padding(.all, 24)
                    .background(Color.gray)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.mainBackground))
                    .cornerRadius(16)
                    .opacity(0.6)
            }
        }
        .accentColor(.smokeBlack)
    }
}

private extension ContentView {
    var whenTextField: some View {
        VStack {
            ZStack(alignment: .center) {
                HStack(spacing: 10) {
                    Image(systemName: "timer")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.placeholderIcon)
                    TextField("", text: $viewModel.whenTextInput)
                        .focused($isFocusedWhen)
                        .frame(height: 57)
                }
                .padding(.horizontal, 16)
                if viewModel.whenTextInput.isEmpty {
                    whenTextFieldPlaceHolder
                }
            }
            .foregroundColor(.smokeBlack)
            .accentColor(.mainBackground)
            .font(.system(size: 18))
            .frame(height: 57, alignment: .top)
            .background(Color.smokeWhite)
            .cornerRadius(30)
            .onTapGesture {
                isFocusedWhen = true
            }
            .shadow(color: .smokeBlack, radius: 2, x: 0, y: 1)
            Text("ă«")
                .font(.title2)
                .foregroundColor(.smokeWhite)
        }
    }

    var whenTextFieldPlaceHolder: some View {
        HStack(spacing: 10) {
            Color.clear
                .frame(width: 25, height: 25)
            Text("äŸïŒăæŒ")
                .font(.system(size: 18))
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .padding([.leading], 5)
    }

    var whereTextField: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    Image(systemName: "location.north.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.placeholderIcon)
                    TextField("", text: $viewModel.whereTextInput)
                        .focused($isFocusedWhere)
                        .frame(height: 57)
                }
                .padding(.horizontal, 16)
                if viewModel.whereTextInput.isEmpty {
                    whereTextFieldPlaceHolder
                }
            }
            .foregroundColor(.smokeBlack)
            .accentColor(.mainBackground)
            .font(.system(size: 18))
            .frame(height: 57, alignment: .top)
            .background(Color.smokeWhite)
            .cornerRadius(30)
            .onTapGesture {
                isFocusedWhere = true
            }
            .shadow(color: .smokeBlack, radius: 2, x: 0, y: 1)
            Text("ă§")
                .font(.title2)
                .foregroundColor(.smokeWhite)
        }
    }

    var whereTextFieldPlaceHolder: some View {
        HStack(spacing: 10) {
            Color.clear
                .frame(width: 25, height: 25)
            Text("äŸïŒă«ăă§")
                .font(.system(size: 18))
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .padding([.leading], 5)
    }

    var whoTextField: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.placeholderIcon)
                    TextField("", text: $viewModel.whoTextInput)
                        .focused($isFocusedWho)
                        .frame(height: 57)
                }
                .padding(.horizontal, 16)
                if viewModel.whoTextInput.isEmpty {
                    whoTextFieldPlaceHolder
                }
            }
            .foregroundColor(.smokeBlack)
            .accentColor(.mainBackground)
            .font(.system(size: 18))
            .frame(height: 57, alignment: .top)
            .background(Color.smokeWhite)
            .cornerRadius(30)
            .onTapGesture {
                isFocusedWho = true
            }
            .shadow(color: .smokeBlack, radius: 2, x: 0, y: 1)
            Text("ăš")
                .font(.title2)
                .foregroundColor(.smokeWhite)
        }
    }

    var whoTextFieldPlaceHolder: some View {
        HStack(spacing: 10) {
            Color.clear
                .frame(width: 25, height: 25)
            Text("äŸïŒćé")
                .font(.system(size: 18))
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .padding([.leading], 5)
    }

    func submitButton(proxy: ScrollViewProxy) -> some View {
        Button(action: {
            viewModel.generateThemes()
            proxy.scrollTo("screen_top")
        }) {
            Text("è©±ăăšăăźăăŒăăŻïŒ")
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
        .alert("ăšă©ăŒ", isPresented: $viewModel.isShowingAlert) {
            Button("OK") {
                // äșè§ŁăăżăłăæŒăăăæăźćŠç
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    var appInfoButton: some View {
        Button(action: {
            isShowingAppInfoScreen = true
        }) {
            Image(systemName: "info.circle")
                .foregroundColor(.smokeBlack)
        }
        .fullScreenCover(isPresented: $isShowingAppInfoScreen) {
            SettingScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
