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
//    let container = PersistenceController.shared.container
    let persistence = PersistenceController.shared
    init() {
        let container = persistence.container
            Task {
                try? await SeedImportService(
                    container: container
                ).importIfNeeded()
            }
        }
    
    var body: some Scene {
        WindowGroup {
            RootView(conteiner: persistence.container)
                .environment(\.managedObjectContext, persistence.container.viewContext)
//                .task {
//                    let importer = SeedImportService(container: container)
//                    try? await importer.importIfNeeded()
//                }
        }
    }
}
