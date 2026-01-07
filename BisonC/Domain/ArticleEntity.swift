//
//  ArticleEntity.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import CoreData

extension ArticleEntity {
    
    var sourcesArray: [SourceEntity] {
        (sources as? Set<SourceEntity>)?.sorted { $0.title ?? "" < $1.title ?? "" } ?? []
    }
    
    func toDomain() -> Article {
        Article(
            id: id ?? "",
            title: title ?? "",
            coverImage: coverImage,
            category: category ?? "",
            summary: summary ?? "",
            content: content ?? "",
            tags: tags  as? [String] ?? [],
            readTime: Int(readTime),
            yearPeriod: yearPeriod,
            sources: (sources as? Set<SourceEntity>)?.map { $0.toDomain() } ?? []
        )
    }
}

extension SourceEntity {
    func toDomain() -> Source {
        Source(
            title: title ?? "",
            publisher: publisher ?? "",
            year: year == 0 ? nil : Int(year),
            note: note,
            urlText: urlText
        )
    }
}
