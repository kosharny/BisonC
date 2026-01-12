//
//  ArticlesRepository.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import Foundation

protocol ArticlesRepository {
    func fetchAll() async throws -> [Article]
    func fetchByCategory(_ categoryId: String) async throws -> [Article]
    func fetchById(_ id: String) async throws -> Article?
    func fetchFeatured() async throws -> Article?
    func fetchRecent(limit: Int) async throws -> [Article]
    
    func toggleFavorite(id: String) async throws
    func fetchFavorites() async throws -> [Article]
    
    func saveHistory(entry: HistoryEntry) async throws
    func fetchHistory() async throws -> [HistoryEntry]
    func deleteHistory(id: String) async throws
    func clearAllHistory() async throws
}
