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
    @Published var errorMessage: String?
    
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
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}




