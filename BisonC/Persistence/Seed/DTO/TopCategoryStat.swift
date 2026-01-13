//
//  TopCategoryStat.swift
//  BisonC
//
//  Created by Maksim Kosharny on 13.01.2026.
//

import Foundation

struct TopCategoryStat: Identifiable {
    let id: String          
    let title: String
    let readCount: Int
    let totalCount: Int

    var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(readCount) / Double(totalCount)
    }
}
