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
    let conteiner: NSPersistentContainer
    
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
    }
    
    @ViewBuilder
    private func destination(for route: AppRouter.Route) -> some View {
        switch route {
        case .search:
            SearchView(
                onBackTap: {
                    router.homePath.removeLast()
                },
                onSearch: { query in
                    router.homePath.append(AppRouter.Route.results(query: query))
                }
            )
            
        case .results(let query):
            ResultsSearchView(
                query: query,
                onArticleTap: { articleId in
                    router.openArticle(articleId)
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


