//
//  ContentView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // FetchRequest для ArticleEntity
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ArticleEntity.title, ascending: true)],
        animation: .default
    )
    private var articles: FetchedResults<ArticleEntity>
    
    var body: some View {
        VStack {
            Text("Check console for imported articles")
                .padding()
            
            List(articles) { article in
                Text(article.title ?? "No title")
            }
        }
        .onAppear {
            print("--- Imported Articles ---")
            for article in articles {
                print("Title: \(article.title ?? "nil"), Tags: \(article.tags as? [String] ?? []), Sources count: \((article.sources as? Set<SourceEntity>)?.count ?? 0)")
            }
            print("--- End ---")
        }
        .onAppear {
            print("--- Imported Articles ---")
            for article in articles {
                print("Title: \(article.title ?? "nil")")
            }
            print("--- End ---")
        }
    }
}
