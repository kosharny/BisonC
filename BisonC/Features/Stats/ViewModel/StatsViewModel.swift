//
//  StatsViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 13.01.2026.
//

import Foundation
import Combine

@MainActor
final class StatsViewModel: ObservableObject {

    @Published private(set) var articlesRead: Int = 0
    @Published private(set) var readingTimeMinutes: Int = 0
    @Published private(set) var topCategories: [TopCategoryStat] = []
    @Published private(set) var isEmpty: Bool = true
    @Published var selectedPeriod: StatsPeriod = .all {
            didSet {
                refreshData()
            }
        }

    private var lastHistory: [HistoryEntry] = []
    private var allArticles: [Article] = []
    private let repository: ArticlesRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: ArticlesRepository) {
        self.repository = repository
        
        NotificationCenter.default.publisher(for: NSNotification.Name("HistoryUpdated"))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                Task {
                    await self?.loadStats()
                }
            }
            .store(in: &cancellables)
    }

    func loadStats() async {
        do {
            let history = try await repository.fetchHistory()
            let articles = try await repository.fetchAll()
            
            self.lastHistory = history
            self.allArticles = articles
            
            guard !history.isEmpty else {
                isEmpty = true
                return
            }

            isEmpty = false
            calculateStats(history: history, articles: articles)

        } catch {
            print("❌ Stats error:", error)
        }
    }
    
    func getArticles(for categoryId: String) -> [Article] {
        return allArticles.filter { $0.category == categoryId }
    }
    
    private func refreshData() {
        calculateStats(history: lastHistory, articles: allArticles)
    }
}

private extension StatsViewModel {
    func calculateStats(history: [HistoryEntry], articles: [Article]) {
        let filteredHistory = filterHistory(history, for: selectedPeriod)
        
        let readArticleIds = Set(filteredHistory.map { $0.articleId })
        let readArticles = articles.filter { readArticleIds.contains($0.id) }

        self.articlesRead = readArticles.count
        self.readingTimeMinutes = readArticles.reduce(0) { $0 + $1.readTime }

        let readByCategory = Dictionary(grouping: readArticles, by: \.category)
        let allByCategory = Dictionary(grouping: articles, by: \.category)

        let stats = allByCategory.map { categoryId, allArticles in
            let readCount = readByCategory[categoryId]?.count ?? 0
            return TopCategoryStat(
                id: categoryId,
                title: categoryId,
                readCount: readCount,
                totalCount: allArticles.count
            )
        }

        topCategories = stats
            .filter { $0.readCount > 0 }
            .sorted { $0.readCount > $1.readCount }
            .prefix(3)
            .map { $0 }

        self.isEmpty = filteredHistory.isEmpty
    }

    func filterHistory(_ history: [HistoryEntry], for period: StatsPeriod) -> [HistoryEntry] {
        let calendar = Calendar.current
        let now = Date()
        
        return history.filter { entry in
            switch period {
            case .week:
                guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: now) else { return true }
                return entry.openedAt >= sevenDaysAgo
            case .month:
                guard let thirtyDaysAgo = calendar.date(byAdding: .day, value: -30, to: now) else { return true }
                return entry.openedAt >= thirtyDaysAgo
            case .all:
                return true
            }
        }
    }
}
