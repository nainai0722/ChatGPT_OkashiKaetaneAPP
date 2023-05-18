//
//  ListRow.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/10.
//

import SwiftUI

struct ListRow: View {
    let task: String
    var isCheecked: Bool
    
    var body: some View {
        HStack{
            if(isCheecked){
                Text("☑")
                Text(task)
                    .strikethrough()
                    .fontWeight(.ultraLight)
            } else {
                Text("□")
                Text(task)
            }
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(task: "料理", isCheecked: true)
    }
}

