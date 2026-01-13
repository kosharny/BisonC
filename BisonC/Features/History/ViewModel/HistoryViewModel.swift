//
//  HistoryViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 12.01.2026.
//

import Foundation
import Combine
import CoreData
import UIKit

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published var historyItems: [HistoryItem] = []
    @Published var errorMessage: String?
    @Published var filteredItems: [HistoryItem] = []
    @Published var selectedPeriod: HistoryPeriod = .all {
        didSet {
            applyFilter()
        }
    }
    
    var isEmpty: Bool {
        filteredItems.isEmpty
    }

    
    private let repository: ArticlesRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(repository: ArticlesRepository) {
        self.repository = repository
        
        NotificationCenter.default.publisher(for: NSNotification.Name("HistoryUpdated"))
            .receive(on: DispatchQueue.main) 
            .sink { [weak self] _ in
                Task {
                    await self?.loadHistory()
                }
            }
            .store(in: &cancellables)
    }
    
    private func applyFilter() {
            let now = Date()
            let calendar = Calendar.current
            
            let result = historyItems.filter { item in
                switch selectedPeriod {
                case .today:
                    return calendar.isDateInToday(item.entry.openedAt)
                case .week:
                    return item.entry.openedAt >= calendar.date(byAdding: .day, value: -7, to: now)!
                case .month:
                    return item.entry.openedAt >= calendar.date(byAdding: .day, value: -30, to: now)!
                case .all:
                    return true
                }
            }
            
            self.filteredItems = result
        }
    
    @MainActor
    func loadHistory() async {
        do {
            let entries = try await repository.fetchHistory()
            
            let sortedEntries = entries.sorted(by: { $0.openedAt > $1.openedAt })
            
            var uniqueItems: [HistoryItem] = []
            var seenArticleIds = Set<String>()
            
            for entry in sortedEntries {
                if !seenArticleIds.contains(entry.articleId) {
                    if let article = try? await repository.fetchById(entry.articleId) {
                        uniqueItems.append(HistoryItem(id: entry.id, entry: entry, article: article))
                        seenArticleIds.insert(entry.articleId)
                    }
                }
            }
            
            self.historyItems = uniqueItems
            applyFilter()
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func removeHistoryEntry(_ id: String) {
        Task {
            do {
                try await repository.deleteHistory(id: id)
                await MainActor.run {
                    self.historyItems.removeAll { $0.id == id }
                    self.applyFilter()
                }
            } catch {
                print("❌ Ошибка при удалении:", error)
            }
        }
    }
    
    func clearAllHistory() {
        Task {
            do {
                try await repository.clearAllHistory()
                await MainActor.run {
                    self.historyItems.removeAll()
                }
            } catch {
                print("❌ Failed to clear history:", error)
            }
        }
    }
    
    func exportHistory() {
        var exportText = "My Reading History\nGenerated on \(Date().formatted())\n\n"
        
        for item in historyItems {
            let date = item.entry.openedAt.formatted(date: .abbreviated, time: .shortened)
            exportText += "• \(item.article.title)\n  Read on: \(date)\n  Category: \(item.article.category)\n\n"
        }
        
        let filename = "ReadingHistory.txt"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        
        do {
            try exportText.write(to: tempURL, atomically: true, encoding: .utf8)
            presentShareSheet(with: tempURL)
        } catch {
            print("❌ Export failed: \(error)")
        }
    }

    private func presentShareSheet(with url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = rootVC.view
                popover.sourceRect = CGRect(x: rootVC.view.bounds.midX, y: rootVC.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            
            rootVC.present(activityVC, animated: true)
        }
    }
}
