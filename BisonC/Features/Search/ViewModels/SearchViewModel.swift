//
//  SearchViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 11.01.2026.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var selectedCategories: Set<String> = []
    @Published var selectedPeriods: Set<String> = []
    @Published var selectedTags: Set<String> = []
    
    @Published private(set) var categories: [Category] = []
    @Published private(set) var periods: [String] = []
    @Published private(set) var tags: [String] = []
    @Published private(set) var history: [String] = []
    
    private var allArticles: [Article] = []
    
    private let repository: ArticlesRepository
    private let historyKey = "searchHistory"
    
    init(repository: ArticlesRepository) {
        self.repository = repository
    }
    
    func loadArticles() async {
        do {
            let articles = try await repository.fetchAll()
            self.allArticles = articles
            setupFilters()
            loadHistorySearch()
        } catch {
            print("❌ Failed to load articles:", error)
        }
    }
    
    private func setupFilters() {
        let uniqueCategories = Set(allArticles.map { $0.category })

        let categoryIcons: [String: String] = [
            "Conservation": "conservationCat",
            "Culture & Tribes": "cultureCat",
            "Myths & Facts": "mythsCat",
            "Places": "placesCat",
            "Species": "speciesCat",
            "Timeline": "timelineCat"
        ]

        categories = uniqueCategories.map { name in
            Category(
                id: name,
                title: name,
                icon: categoryIcons[name] ?? "category_placeholder",
                description: ""
            )
        }

        periods = Array(Set(allArticles.compactMap { $0.yearPeriod })).sorted()
        tags = Array(Set(allArticles.flatMap { $0.tags })).sorted()
    }

    
    private func loadHistorySearch() {
        history = UserDefaults.standard.stringArray(forKey: historyKey) ?? []
    }
    
    private func saveHistory(_ query: String) {
        var updated = history.filter { $0 != query }
        updated.insert(query, at: 0)
        if updated.count > 5 { updated.removeLast() } 
        history = updated
        UserDefaults.standard.set(history, forKey: historyKey)
    }

    func removeHistoryItem(_ query: String) {
        history.removeAll { $0 == query }
        UserDefaults.standard.set(history, forKey: historyKey)
    }
    
    func filteredArticles() -> [Article] {
        
        if !searchText.isEmpty {
            saveHistory(searchText)
        }
        
        let filtered = allArticles.filter { article in
            let matchesText = searchText.isEmpty || article.title.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(article.category)
            let matchesPeriod = selectedPeriods.isEmpty || selectedPeriods.contains(article.yearPeriod ?? "")
            let matchesTags = selectedTags.isEmpty || !Set(article.tags).isDisjoint(with: selectedTags)

            let passesFilters = matchesText && (matchesCategory || matchesPeriod || matchesTags)
            
            return passesFilters
        }
        
        return filtered
    }
    
    func toggleCategory(_ id: String) { selectedCategories.toggleMembership(id) }
    func togglePeriod(_ period: String) { selectedPeriods.toggleMembership(period) }
    func toggleTag(_ tag: String) { selectedTags.toggleMembership(tag) }
    func resetFilters() {
        searchText = ""
        selectedCategories.removeAll()
        selectedPeriods.removeAll()
        selectedTags.removeAll()
    }
}

private extension Set where Element: Hashable {
    mutating func toggleMembership(_ element: Element) {
        if contains(element) { remove(element) } else { insert(element) }
    }
}


struct ArticlesJSON: Codable {
    let articles: [Article]
}



