//
//  Draft.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/11.
//


import SwiftUI

//struct Draft: View {
//    @State var taskTitle = ""
//    @EnvironmentObject var userData: UserData
//
//    @Environment(\.managedObjectContext) var viewContext
//
//    var body: some View {
//        TextField("タスクを入力してください", text: $taskTitle, onCommit: {
//            self.createTask()
//            self.userData.isEditing = false
//        })
//    }
//
//    func createTask() {
//        let newTask = ShoppingHistoryList(context: viewContext)
//        newTask.title = self.taskTitle
//        newTask.checked = false
//        self.taskTitle = ""
//
//        do {
//            try viewContext.save()
//        } catch {
//            fatalError("セーブに失敗")
//        }
//    }
//}
struct Draft: View {
    @State var taskTitle = ""
    @EnvironmentObject var userData: UserData
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack {
            TextField("タスクを入力してください", text: $taskTitle, onCommit: {
                self.createTask()
                self.userData.isEditing = false
            })
            
            NavigationLink(destination: NextView(), isActive: $userData.isEditing) {
                EmptyView()
            }
        }
    }
    
    func createTask() {
        let newTask = ShoppingHistoryList(context: viewContext)
        newTask.title = self.taskTitle
        newTask.checked = false
        self.taskTitle = ""
        
        do {
            try viewContext.save()
            self.userData.isEditing = true // 画面遷移を実行するためにフラグを変更
        } catch {
            fatalError("セーブに失敗")
        }
    }
}

struct Draft_Previews: PreviewProvider {
    static var previews: some View {
        Draft()
    }
}

struct NextView: View {
    var body: some View {
        Text("Next View")
    }
}
