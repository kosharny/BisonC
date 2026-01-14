//
//  ArticleUIModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 11.01.2026.
//

import Foundation

struct ArticleUIModel: Identifiable {
    let id: String
    let title: String
    let summary: String
    let content: String
    let tags: [String]
    let intro: String
    let details: String
    let problem: String
    let conclusion: String
    let imageName: String
    let category: String
    let readTimeText: String
    let yearPeriod: String?
    var isFavorite: Bool
}

extension Article {
    func toUIModel() -> ArticleUIModel {
        let textParts = splitContentIntoFourParts(content)
        
        return ArticleUIModel(
            id: id,
            title: title,
            summary: summary,
            content: content,
            tags: tags,
            intro: textParts[0],
            details: textParts[1],
            problem: textParts[2],
            conclusion: textParts[3],
            imageName: coverImage ?? "placeholder",
            category: category,
            readTimeText: "\(readTime) min read",
            yearPeriod: yearPeriod,
            isFavorite: isFavorite
        )
    }
    
    func splitContentIntoFourParts(_ fullText: String) -> [String] {
        let sentences = fullText.components(separatedBy: ". ")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        guard !sentences.isEmpty else { return ["", "", "", ""] }
        
        let totalSentences = sentences.count
        let chunkSize = max(1, totalSentences / 4)
        
        var parts: [String] = []
        
        for i in 0..<4 {
            let start = i * chunkSize
            let end = (i == 3) ? totalSentences : min(start + chunkSize, totalSentences)
            
            if start < totalSentences {
                let chunk = sentences[start..<end].joined(separator: ". ")
                parts.append(chunk.hasSuffix(".") ? chunk : chunk + ".")
            } else {
                parts.append("")
            }
        }
        
        return parts
    }
}
