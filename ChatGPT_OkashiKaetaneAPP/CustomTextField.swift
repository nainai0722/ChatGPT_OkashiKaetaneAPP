//
//  CustomTextField.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/10.
//

import SwiftUI

struct CustomTextField: View {
    let priceData:PriceData
    @Binding var answer: String
    
    var body:some View {
        TextField("100", text: Binding(
            get:{
                priceData.price == 0 ? "" : String(priceData.price)
            },
            set:{ newValue in var limitedValue = newValue
                    .prefix(3)
                    .filter { "0123456789".contains($0) }
                if limitedValue.isEmpty {
                    limitedValue = "0"
                }
                priceData.price = Int(limitedValue) ?? 0
            }
        ))
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .keyboardType(.numberPad)
        .font(.title)
        .onTapGesture {
            priceData.price = 0
            answer = ""
        }
        Text("円")
            .font(.subheadline)
    }
}
