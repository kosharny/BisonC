//
//  BisonCApp.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI
import CoreData

@main
struct BisonCApp: App {
    let container = PersistenceController.shared.container
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, container.viewContext)
                .task {
                    let importer = SeedImportService(container: container)
                    try? await importer.importIfNeeded()
                }
        }
    }
}
