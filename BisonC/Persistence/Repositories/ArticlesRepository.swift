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
}
