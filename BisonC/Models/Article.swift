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
    let category: String
    let summary: String
    let content: String
    let tags: [String]
    let readTime: Int
    let yearPeriod: String?
    let sources: [Source]
    
    var isFavorite: Bool = false
    var lastOpenedDate: Date? = nil
}
