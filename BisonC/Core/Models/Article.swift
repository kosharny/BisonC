//
//  Article.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import Foundation

struct Article: Identifiable, Codable {
    let id: String
    let title: String
    let coverImage: String?
    let categoryId: String
    let summary: String
    let content: String
    let tags: [String]
    let readTime: Int
    let sources: [Source]
    let yearPeriod: String?
    
    var isFavorite: Bool = false
    var lastOpenedDate: Date? = nil
}
