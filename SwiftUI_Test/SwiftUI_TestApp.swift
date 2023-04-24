//
//  SwiftUI_TestApp.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import SwiftUI

@main
struct SwiftUI_TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
