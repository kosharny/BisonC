//
//  HistoryEntry.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import Foundation

struct HistoryEntry: Identifiable {
    let id: String
    let articleId: String
    let openedAt: Date
    let categoryId: String
    var progress: Double
}
