//
//  FavoritesViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 12.01.2026.
//

import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    
    @Published var articles: [ArticleUIModel] = []
    @Published var errorMessage: String?
    
    var isEmpty: Bool {
        articles.isEmpty
    }
    
    private let repository: ArticlesRepository
    
    init(repository: ArticlesRepository) {
        self.repository = repository
        Task { await loadFavorites() }
        
        NotificationCenter.default.addObserver(
            forName: .favoriteChanged,
            object: nil,
            queue: .main
        ) { [weak self] notif in
            guard let self = self,
                  let info = notif.userInfo,
                  let id = info["id"] as? String,
                  let isFav = info["isFavorite"] as? Bool
            else { return }
            
            Task { @MainActor in
                self.syncFavoriteChange(articleId: id, isFavorite: isFav)
            }
        }
    }
    
    @MainActor
    func loadFavorites() async {
        do {
            let all = try await repository.fetchAll()
            articles = all.filter { $0.isFavorite }.map { $0.toUIModel() }
        } catch {
            print("Failed to load favorites:", error)
        }
    }
    
    @MainActor
    func syncFavoriteChange(articleId: String, isFavorite: Bool) {
        if isFavorite {
            Task {
                if let art = try? await repository.fetchById(articleId),
                   !articles.contains(where: { $0.id == articleId }) {
                    articles.append(art.toUIModel())
                }
            }
        } else {
            articles.removeAll { $0.id == articleId }
        }
    }
    
    func removeFromFavorites(_ id: String) {
        Task {
            do {
                try await repository.toggleFavorite(id: id)
                articles.removeAll { $0.id == id }
            } catch {
                print("❌ Failed to remove favorite:", error)
            }
        }
    }
    
    func clearAllFavorites() {
        Task {
            for article in articles {
                do {
                    try await repository.toggleFavorite(id: article.id)
                } catch {
                    print("❌ Failed to remove favorite for \(article.id):", error)
                }
            }
            articles.removeAll()
        }
    }

}

