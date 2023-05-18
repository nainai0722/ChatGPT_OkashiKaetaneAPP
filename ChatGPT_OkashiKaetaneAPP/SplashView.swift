//
//  SplashView.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/11.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("kids_youchien_oyatsu") // スプラッシュ画像の名前に置き換える
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .frame(width: 300, height: 300)
            .clipShape(Circle())
    }
}
