//
//  MainTabView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI
import CoreData

struct MainTabView: View {
    
    @State private var selectedTab: Int = 0
    @StateObject private var router = AppRouter()
    @StateObject private var searchVM: SearchViewModel
    @StateObject private var historyVM: HistoryViewModel
    @StateObject private var statsVM: StatsViewModel
    
    @StateObject private var settingsVM = SettingsViewModel()
    
    let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
        _searchVM = StateObject(wrappedValue: SearchViewModel(
            repository: ArticlesRepositoryCoreData(container: container)
        ))
        _historyVM = StateObject(
                    wrappedValue: HistoryViewModel(
                        repository: ArticlesRepositoryCoreData(container: container)
                    )
                )
        _statsVM = StateObject(
                    wrappedValue: StatsViewModel(
                        repository: ArticlesRepositoryCoreData(container: container)
                    )
                )
    }
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $router.homePath) {
                HomeView(
                    container: container,
                    onSearchTap: {
                        router.homePath.append(AppRouter.Route.search)
                    },
                    onArticleTap: { articleId in
                        router.homePath.append(AppRouter.Route.article(id: articleId))
                    },
                    onCategoryTap: { categoryIDs in
                        Task {
                            let allArticles = try? await ArticlesRepositoryCoreData(container: container).fetchAll()
                            let filtered = allArticles?.filter { categoryIDs.contains($0.category) } ?? []
                            let ids = filtered.map { $0.id }
                            
                            router.homePath.append(.results(articleIds: ids))
                        }
                    },
                    onQuickAccessTap: { title in
                        Task {
                            let allArticles = try? await ArticlesRepositoryCoreData(container: container).fetchAll()
                            
                            let filtered = allArticles?.filter { article in
                                article.category.lowercased() == title.lowercased() ||
                                (title == "Tribes & Culture" && article.category == "Tribes")
                            } ?? []
                            
                            let ids = filtered.map { $0.id }
                            
                            await MainActor.run {
                                router.homePath.append(.results(articleIds: ids))
                            }
                        }
                    }
                )
                .navigationDestination(for: AppRouter.Route.self) { route in
                    destination(for: route)
                }
            }
            .tabItem {
                Image("home")
            }
            .tag(0)
            
            NavigationStack(path: $router.favoritesPath) {
                FavoritesView(
                    container: container,
                    onArticleTap: { articleId in
                        router.favoritesPath.append(AppRouter.Route.article(id: articleId))
                    }
                )
                .navigationDestination(for: AppRouter.Route.self) { route in
                    destination(for: route)
                }
            }
            .tabItem {
                Image("favorites")
            }
            .tag(1)
            
            HistoryView(vm: historyVM)
                .tabItem {
                    Image("history")
                }
                .tag(2)
            NavigationStack(path: $router.statsPath) {
                StatsView(vm: statsVM) { articles in
                    let ids = articles.map(\.id)
                    router.statsPath.append(.results(articleIds: ids))
                }
                .navigationDestination(for: AppRouter.Route.self) { route in
                    destination(for: route)
                }
            }
            .tabItem {
                Image("statistics")
            }
            .tag(3)
                
            NavigationStack(path: $router.settingsPath) {
                SettingsView(
                    vm: settingsVM,
                    onAboutTap: {
                        router.settingsPath.append(AppRouter.Route.about)
                    },
                    onExportData: {
                        historyVM.exportHistory()
                    },
                    onResetHistory: {
                        historyVM.clearAllHistory() 
                    }
                )
                .navigationDestination(for: AppRouter.Route.self) { route in
                    destination(for: route)
                }
            }
            .tabItem {
                Image("settings")
            }
            .tag(4)
        }
        .toolbarBackground(.thickMaterial, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .task {
            await searchVM.loadArticles()
            await historyVM.loadHistory()
            await statsVM.loadStats()
        }
        .environmentObject(settingsVM)
        .id(settingsVM.textSize)
        .onAppear {
            selectedTab = 0
            settingsVM.applyTheme()
        }
    }
    
    @ViewBuilder
    private func destination(for route: AppRouter.Route) -> some View {
        switch route {
        case .search:
            SearchView(
                vm: searchVM,
                onBackTap: { router.homePath.removeLast() },
                onSearch: { articles in
                    let ids = articles.map(\.id)
                    router.homePath.append(.results(articleIds: ids))
                }
            )
            
        case .results(let articleIDs):
            ResultsSearchView(
                articleIDs: articleIDs,
                repository: ArticlesRepositoryCoreData(container: container),
                onArticleTap: { id in
                    if !router.statsPath.isEmpty {
                        router.statsPath.append(.article(id: id))
                    } else if !router.homePath.isEmpty {
                        router.homePath.append(.article(id: id))
                    }
                },
                onBackTap: {
                    if !router.statsPath.isEmpty {
                        router.statsPath.removeLast()
                    } else {
                        router.homePath.removeLast()
                    }
                }
            )
            
        case .article(let id):
            ArticleView(
                articleId: id, repository: ArticlesRepositoryCoreData(container: container),
                onBackTap: {
                    if router.homePath.count > 0 {
                        router.homePath.removeLast()
                    } else {
                        router.favoritesPath.removeLast()
                    }
                },
                onReady: {
                    if !router.homePath.isEmpty { router.homePath.removeAll() }
                    if !router.favoritesPath.isEmpty { router.favoritesPath.removeAll() }
                    if !router.statsPath.isEmpty { router.statsPath.removeAll() }
                    
                    selectedTab = 0
                }
            )
        case .about:
            AboutView(
                onBackTap: {
                    router.settingsPath.removeLast()
                }
            )
        }
    }
}


