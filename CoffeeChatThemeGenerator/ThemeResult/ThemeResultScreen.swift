//
//  ThemeResultScreen.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/19.
//

import SwiftUI

struct ThemeResultScreen: View {
    let theme: String

    var body: some View {
        ZStack {
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                ZStack {
                    VStack {
                        Spacer()
                            .frame(height: 220)
                        Color.smokeWhite
                            .edgesIgnoringSafeArea(.all)
                    }
                    VStack(spacing: 0) {
                        LottieView(animationType: .friends)
                            .frame(height: 240)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("こんなテーマはいかがですか？")
                                .font(.title)
                                .foregroundColor(.smokeBlack)
                                .bold()
                            Text(theme)
                                .font(.title2)
                                .foregroundColor(.smokeBlack)
                            Spacer()
                            shareButton
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 40)
                }
            }
        }
    }
}

private extension ThemeResultScreen {
    var shareButton: some View {
        ShareLink(item: sharedText) {
            Text("結果を共有する")
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

    var sharedText: String {
        return "話したいことは、\n\(theme)\n\ncreated by テーマジェネレーター"
    }
}

struct ThemeResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThemeResultScreen(theme: "1. お互いの趣味・趣向の違いや共通点\n2. 職業・仕事について\n3. 将来の夢や目標")
    }
}
