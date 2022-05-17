//
//  UI_564App.swift
//  UI-564
//
//  Created by nyannyan0328 on 2022/05/17.
//

import SwiftUI

@main
struct UI_564App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
