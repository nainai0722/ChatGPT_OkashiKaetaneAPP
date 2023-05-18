//
//  PriceData.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/03/24.
//
import SwiftUI

class PriceData: ObservableObject {
    @Published var price : Int
    @Published var id: Int
    
    init(price: Int,id: Int){
        self.price = price
        self.id = id
    }
}
