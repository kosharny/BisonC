//
//  HistoryItem.swift
//  BisonC
//
//  Created by Maksim Kosharny on 12.01.2026.
//

import Foundation

struct HistoryItem: Identifiable {
    let id: String
    let entry: HistoryEntry
    let article: Article
}
