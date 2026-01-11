//
//  HomeViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 11.01.2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var heroArticle: ArticleUIModel?
    @Published var popularArticles: [ArticleUIModel] = []
    @Published var categories: [Category] = []
    @Published var errorMessage: String?
    
    @Published var selectedCategories: Set<String> = []
    
    private let repository: ArticlesRepository
    
    init(repository: ArticlesRepository) {
        self.repository = repository
    }
    
    func load() {
        Task {
            do {
                let all = try await repository.fetchAll()
                heroArticle = all.first?.toUIModel()
                popularArticles = all.map { $0.toUIModel() }
                
                loadCategories(from: all)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    private func loadCategories(from articles: [Article]) {
        let uniqueCategories = Set(articles.map { $0.category })
        categories = uniqueCategories.map { name in
            Category(
                id: name,
                title: name,
                icon: nameToIcon(name),
                description: ""
            )
        }
    }
    
    private func nameToIcon(_ categoryName: String) -> String {
        let categoryIcons: [String: String] = [
            "Conservation": "conservationCat",
            "Culture & Tribes": "cultureCat",
            "Myths & Facts": "mythsCat",
            "Places": "placesCat",
            "Species": "speciesCat",
            "Timeline": "timelineCat"
        ]
        
        return categoryIcons[categoryName] ?? "category_placeholder"
    }
}




