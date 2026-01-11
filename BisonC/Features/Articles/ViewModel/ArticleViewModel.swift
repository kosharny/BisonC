//
//  ArticleViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 11.01.2026.
//

import Foundation
import Combine

@MainActor
final class ArticleViewModel: ObservableObject {
    @Published var article: ArticleUIModel?
    @Published var errorMessage: String?
    
    private let repository: ArticlesRepository
    private let articleId: String
    
    init(articleId: String, repository: ArticlesRepository) {
        self.articleId = articleId
        self.repository = repository
    }
    
    func load() {
        Task {
            do {
                if let article = try await repository.fetchById(articleId) {
                    self.article = article.toUIModel()
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

