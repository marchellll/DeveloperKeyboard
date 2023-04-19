//
//  DeveloperKeyboardApp.swift
//  DeveloperKeyboard
//
//  Created by Marchell Imanuel on 19/04/23.
//

import SwiftUI

@main
struct DeveloperKeyboardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
