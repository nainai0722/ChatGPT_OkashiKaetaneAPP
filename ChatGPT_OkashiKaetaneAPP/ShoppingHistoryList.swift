//
//  ShoppingHistoryList.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/10.
//

import SwiftUI
import CoreData

struct ShoppingHistoryList: View {
    @EnvironmentObject var userData: UserData
    @State private var username: String = ""
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [])
    var tasks: FetchedResults<ShoppingList>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    Button(action: {
                        task.checked.toggle()
                    }) {
                        if (task.title?.isEmpty == false) {
                            ListRow(task: task.title!, isCheecked: task.checked)
                        }
                    }
                }
                if self.userData.isEditing {
                    Draft()
                } else {
                    Button(action: {
                        self.userData.isEditing = true
                    }) {
                        Text("+")
                            .font(.title)
                    }
                }
            }
            .navigationBarTitle(Text("Tasks"))
            .navigationBarItems(trailing: Button(action: {
                DeleteTask()
            }) {
                Text("Delete")
            })
        }
    }
    
    func DeleteTask() {
        for task in tasks {
            if task.checked {
                viewContext.delete(task)
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗")
        }
    }
}
