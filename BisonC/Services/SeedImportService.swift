//
//  SeedImportService.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import CoreData

final class SeedImportService {
    private let container: NSPersistentContainer
    private let userDefaults: UserDefaults
    
    private let seedImportedKey = "seed_import_completed"
    
    init(container: NSPersistentContainer,
         userDefaults: UserDefaults = .standard) {
        self.container = container
        self.userDefaults = userDefaults
    }
    
    func importIfNeeded() async throws {
        guard !userDefaults.bool(forKey: seedImportedKey) else { return }
        try await importSeed()
        userDefaults.set(true, forKey: seedImportedKey)
    }
    
    private func importSeed() async throws {
        let context = container.newBackgroundContext()

        let articles = try loadSeedArticles()
        try await context.perform {
            for dto in articles {

                let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", dto.id)
                request.fetchLimit = 1

                let entity = try context.fetch(request).first
                    ?? ArticleEntity(context: context)

                entity.id = dto.id
                entity.title = dto.title
                entity.summary = dto.summary
                entity.content = dto.content
                entity.category = dto.category
                entity.coverImage = dto.coverImage
                entity.tags = dto.tags as NSArray
                entity.readTime = Int32(dto.readTime)
                entity.yearPeriod = dto.yearPeriod
            }

            try context.save()
        }
    }

    
//    private func importSeed() async throws {
//        let context = container.newBackgroundContext()
//        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//        let articles = try loadSeedArticles()
//
//        try await context.perform {
//            for dto in articles {
//                let entity = ArticleEntity(context: context)
//                entity.id = dto.id
//                entity.title = dto.title
//                entity.summary = dto.summary
//                entity.content = dto.content
//                entity.category = dto.category
//                entity.coverImage = dto.coverImage
//                entity.tags = NSArray(array: dto.tags)
//                entity.readTime = Int32(dto.readTime)
//                entity.yearPeriod = dto.yearPeriod
//
//                if let sources = dto.sources {
//                    for s in sources {
//                        let src = SourceEntity(context: context)
//                        src.title = s.title
//                        src.publisher = s.publisher
//                        src.year = s.year.map(Int32.init) ?? 0
//                        src.note = s.note
//                        src.urlText = s.urlText
//                        src.article = entity
//                    }
//                }
//            }
//
//            try context.save()
//        }
//    }

    
    private func loadSeedArticles() throws -> [ArticleSeedDTO] {
        guard let url = Bundle.main.url(forResource: "articles_seed", withExtension: "json")
        else { throw NSError(domain: "Seed", code: 1, userInfo: [NSLocalizedDescriptionKey: "Seed file not found"]) }
        
        let data = try Data(contentsOf: url)
        
        let file = try JSONDecoder().decode(ArticlesSeedFile.self, from: data)
        return file.articles
    }
}

