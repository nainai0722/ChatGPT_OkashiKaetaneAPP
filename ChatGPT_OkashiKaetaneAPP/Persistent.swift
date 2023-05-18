//
//  Persistent.swift
//  ChatGPT_OkashiKaetaneAPP
//
//  Created by 指原奈々 on 2023/05/11.
//

import CoreData

struct PersistenceController {
    let containar: NSPersistentContainer
    
    init() {
        containar = NSPersistentContainer(name: "OkashiKaetaneAPP")
        
        containar.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
