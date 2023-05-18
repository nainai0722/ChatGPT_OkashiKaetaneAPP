//
//  UserTask.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/10.
//

import SwiftUI

struct Task:Identifiable, Equatable {
    let id = UUID()
    var title: String
    var checked: Bool
    
    init(title: String, checked: Bool) {
        self.title = title
        self.checked = checked
    }
}

