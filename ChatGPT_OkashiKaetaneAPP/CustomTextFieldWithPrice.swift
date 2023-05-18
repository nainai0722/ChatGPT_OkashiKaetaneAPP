//
//  CustomTextFieldWithPrice.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/10.
//

import SwiftUI
struct CustomTextFieldWithPrice: View {
    let budget:BudgetData
    @Binding var answer: String
    
    var body:some View {
        TextField("300", text: Binding(
            get:{
                budget.budget == 0 ? "" : String(budget.budget)
            },
            set: { newValue in var limitedValue = newValue
                    .prefix(4)
                    .filter { "0123456789".contains($0) }
                if limitedValue.isEmpty {
                    limitedValue = "0"
                }
                budget.budget = Int(limitedValue) ?? 0
            }
        ))
        .font(.title)
        .frame(width: 150, height: 200)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .keyboardType(.numberPad)
        .onTapGesture {
            budget.budget = 0
            answer = ""
        }
        Text("円")
            .font(.subheadline)
    }
}

