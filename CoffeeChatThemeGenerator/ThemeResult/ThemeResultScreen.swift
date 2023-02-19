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
        Text(theme)
    }
}

struct ThemeResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThemeResultScreen(theme: "1. お互いの趣味・趣向の違いや共通点\n2. 職業・仕事について\n3. 将来の夢や目標")
    }
}
