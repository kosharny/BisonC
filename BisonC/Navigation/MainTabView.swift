//
//  MainTabView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI
import CoreData

struct MainTabView: View {
    
    
    @StateObject private var router = AppRouter()
    @StateObject private var searchVM: SearchViewModel
    @StateObject private var historyVM: HistoryViewModel
    @StateObject private var statsVM: StatsViewModel
    
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
        TabView {
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
                    }
                )
                .navigationDestination(for: AppRouter.Route.self) { route in
                    destination(for: route)
                }
            }
            .tabItem {
                Image("home")
            }
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
            
            HistoryView(vm: historyVM)
                .tabItem {
                    Image("history")
                }
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
                
            NavigationStack(path: $router.settingsPath) {
                SettingsView(
                    onAboutTap: {
                        router.settingsPath.append(AppRouter.Route.about)
                    }
                )
                .navigationDestination(for: AppRouter.Route.self) { route in
                    destination(for: route)
                }
            }
            .tabItem {
                Image("settings")
            }
        }
        .toolbarBackground(.thickMaterial, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .task {
            await searchVM.loadArticles()
            await historyVM.loadHistory()
            await statsVM.loadStats()
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


