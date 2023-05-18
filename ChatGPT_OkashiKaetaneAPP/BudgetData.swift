//
//  BudgetData.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/03/29.
//
import SwiftUI

class BudgetData: ObservableObject {
    @Published var budget : Int
    @Published var inputBudget: Int
    
    init(budget: Int,inputBudget: Int){
        self.budget = budget
        self.inputBudget = inputBudget
    }
}
