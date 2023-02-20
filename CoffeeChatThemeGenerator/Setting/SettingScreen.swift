//
//  SettingScreenn.swift
//  CoffeeChatThemeGenerator
//
//  Created by mikaurakawa on 2023/02/19.
//

import SwiftUI
import AppInfoList

struct SettingScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            AppInfoListView(
                appearance: AppInfoAppearance(
                    cellTextColor: .smokeBlack,
                    versionTextColor: .smokeBlack,
                    cellTitles: CellTitles(termsOfUse: "利用規約・プライバシーポリシー")
                ),
                info: AppInfo(
                    termOfUseURL: URL(string: "https://kamimi01.github.io/CoffeeChatThemeGenerator/privacy_policy/ja.html")!,
                    developerInfoURL: URL(string: "https://twitter.com/kamimi_01")!
                ),
                licenseFileURL: Bundle.main.url(forResource: "license-list", withExtension: "plist")!
            )
            .navigationTitle("アプリについて")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    dismissButton
                }
            }
        }
        .accentColor(.smokeBlack)
    }
}

private extension SettingScreen {
    var dismissButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "multiply")
                .foregroundColor(.smokeBlack)
        }
    }
}
struct SettingScreenn_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
