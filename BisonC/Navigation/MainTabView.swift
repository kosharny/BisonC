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
    
    let conteiner: NSPersistentContainer
    
    init(conteiner: NSPersistentContainer) {
        self.conteiner = conteiner
        _searchVM = StateObject(wrappedValue: SearchViewModel(
            repository: ArticlesRepositoryCoreData(container: conteiner)
        ))
    }
    
    
    var body: some View {
        TabView {
            NavigationStack(path: $router.homePath) {
                HomeView(
                    container: conteiner,
                    onSearchTap: {
                        router.homePath.append(AppRouter.Route.search)
                    },
                    onArticleTap: { articleId in
                        router.homePath.append(AppRouter.Route.article(id: articleId))
                    },
                    onCategoryTap: { categoryIDs in
                        Task {
                            let allArticles = try? await ArticlesRepositoryCoreData(container: conteiner).fetchAll()
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
                    container: conteiner,
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
            
            HistoryView()
                .tabItem {
                    Image("history")
                }
            
            StatsView()
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
                    print("🚀 Filtered articles count:", articles.count)
                    let ids = articles.map(\.id)
                    print("Filtered IDs:", ids)
                    router.homePath.append(.results(articleIds: ids))
                }
            )
            
        case .results(let articleIDs):
            ResultsSearchView(
                articleIDs: articleIDs,
                repository: ArticlesRepositoryCoreData(container: conteiner),
                onArticleTap: { id in
                    router.openArticle(id)
                },
                onBackTap: {
                    router.homePath.removeLast()
                }
            )
            
        case .article(let id):
            ArticleView(
                articleId: id, repository: ArticlesRepositoryCoreData(container: conteiner),
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


