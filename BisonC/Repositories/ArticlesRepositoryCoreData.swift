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
}
