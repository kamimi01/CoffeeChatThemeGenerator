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
        VStack(alignment: .leading, spacing: 20) {
            Text("こんなテーマで話しましょう")
                .font(.title2)
                .foregroundColor(.smokeBlack)
                .bold()
            Text(theme)
                .font(.title3)
                .foregroundColor(.smokeBlack)
        }
        .padding(.horizontal, 16)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                shareButton
            }
        }
    }
}

private extension ThemeResultScreen {
    var shareButton: some View {
        ShareLink(item: sharedText) {
            Image(systemName: "square.and.arrow.up")
        }
        .foregroundColor(.smokeBlack)
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
