//
//  ResultsSearchViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 11.01.2026.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class ResultsSearchViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var selectedSort: String = "Most relevant"
    
    let sortOptions = ["Most relevant", "Newest", "Oldest", "A-Z"]
    
    private let repository: ArticlesRepository
    
    init(repository: ArticlesRepository, articleIDs: [String]) {
        self.repository = repository
        loadArticles(ids: articleIDs)
    }
    
    func loadArticles(ids: [String]) {
        Task {
            do {
                let all = try await repository.fetchAll()
                let filtered = all.filter { ids.contains($0.id) }
                self.articles = sortArticles(filtered)
            } catch {
                print("❌ Failed to load articles for ResultsSearchViewModel:", error)
            }
        }
    }
    
    func sortArticles(_ articles: [Article]) -> [Article] {
        switch selectedSort {
        case "Newest":
            return articles.sorted(by: { ($0.yearStart ?? 0) > ($1.yearStart ?? 0) })
        case "Oldest":
            return articles.sorted(by: { ($0.yearStart ?? 0) < ($1.yearStart ?? 0) })
        case "A-Z":
            return articles.sorted(by: { $0.title < $1.title })
        default: 
            return articles
        }
    }

    
    func updateSort(to option: String) {
        selectedSort = option
        articles = sortArticles(articles)
    }
}
