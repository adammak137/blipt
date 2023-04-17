//
//  BliptApp.swift
//  Blipt
//
//  Created by Travis Baksh on 4/17/23.
//

import SwiftUI

@main
struct BliptApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
