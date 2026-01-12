//
//  HistoryViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 12.01.2026.
//

import Foundation
import Combine

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published var historyItems: [HistoryItem] = []
    @Published var errorMessage: String?
    @Published var filteredItems: [HistoryItem] = []
    @Published var selectedPeriod: HistoryPeriod = .all {
        didSet {
            objectWillChange.send()
        }
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
                    self.applyFilter() // Снова пересчитываем фильтр
                    print("✅ Экран должен обновиться. Осталось в фильтре: \(filteredItems.count)")
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
}
