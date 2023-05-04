//
//  Camera_GPTApp.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import SwiftUI
import CoreData

@main
struct Camera_GPTApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
