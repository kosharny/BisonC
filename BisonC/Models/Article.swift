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
    
    var yearStart: Int? {
            guard let yearPeriod = yearPeriod else { return nil }
            let components = yearPeriod.components(separatedBy: "–")
            if let first = components.first, let y = Int(first) {
                return y
            }
            return nil
        }
}
