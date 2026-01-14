//
//  ArticlesRepository.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import Foundation

protocol ArticlesRepository {
    func fetchAll() async throws -> [Article]
    func fetchById(_ id: String) async throws -> Article?
    
    func toggleFavorite(id: String) async throws
    
    func saveHistory(entry: HistoryEntry) async throws
    func fetchHistory() async throws -> [HistoryEntry]
    func deleteHistory(id: String) async throws
    func clearAllHistory() async throws
}
