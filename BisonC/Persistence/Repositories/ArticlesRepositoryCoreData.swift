//
//  ArticlesRepositoryCoreData.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import CoreData

final class ArticlesRepositoryCoreData: ArticlesRepository {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func fetchAll() async throws -> [Article] {
        let context = container.viewContext
        
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        let result = try context.fetch(request)
        return result.map { $0.toDomain() }
    }
    
    func fetchByCategory(_ categoryId: String) async throws -> [Article] {
        let context = container.viewContext
        
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", categoryId)
        
        let result = try context.fetch(request)
        return result.map { $0.toDomain() }
    }
    
    func fetchById(_ id: String) async throws -> Article? {
        let context = container.viewContext
        
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        
        return try context.fetch(request).first?.toDomain()
    }
    
    func fetchFeatured() async throws -> Article? {
        let context = container.viewContext
        
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "yearPeriod", ascending: false)
        ]
        request.fetchLimit = 1
        
        return try context.fetch(request).first?.toDomain()
    }
    
    func fetchRecent(limit: Int) async throws -> [Article] {
        let context = container.viewContext
        
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "lastOpenedDate", ascending: false)
        ]
        request.fetchLimit = limit
        
        let result = try context.fetch(request)
        return result.map { $0.toDomain() }
    }
    
    func fetchFavorites() async throws -> [Article] {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        return try container.viewContext.fetch(request).map { $0.toDomain() }
    }
    
    func toggleFavorite(id: String) async throws {
        let context = container.viewContext
        
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        
        guard let entity = try context.fetch(request).first else { return }
        
        entity.isFavorite.toggle()
        try context.save()
        
        
        try context.save()
    }
    
    func saveHistory(entry: HistoryEntry) async throws {
        let context = container.viewContext
        
        let entity = HistoryEntity(context: context)
        entity.id = entry.id
        entity.articleId = entry.articleId
        entity.openedAt = entry.openedAt
        entity.categoryId = entry.categoryId
        entity.progress = entry.progress
        
        try context.save()
    }
    
    func fetchHistory() async throws -> [HistoryEntry] {
        let context = container.viewContext
        
        let request: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "openedAt", ascending: false)]
        
        request.shouldRefreshRefetchedObjects = true
        
        let result = try context.fetch(request)
        return result.map { $0.toDomain() }
    }
    
    func deleteHistory(id: String) async throws {
        let context = container.viewContext
        
        let request: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        
        if let entity = try context.fetch(request).first {
            context.delete(entity)
            try context.save()
        }
    }
    
    func clearAllHistory() async throws {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = HistoryEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try context.execute(batchDeleteRequest)
        try context.save()
    }
}
