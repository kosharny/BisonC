//
//  FavoritesView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    
    @StateObject private var vm: FavoritesViewModel
    
    let onArticleTap: (String) -> Void
    
    init(container: NSPersistentContainer, onArticleTap: @escaping (String) -> Void) {
        _vm = StateObject(
            wrappedValue: FavoritesViewModel(
                repository: ArticlesRepositoryCoreData(container: container)
            )
        )
        self.onArticleTap = onArticleTap
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Image("favoritesLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 50)
                    Spacer()
                }
                .padding(.top, getSafeAreaTop())
                .padding()
                if vm.isEmpty {
                    Spacer()
                    EmptyView(isFavorites: true, title: "No favorites yet")
                        .padding(.bottom, getSafeAreaBottom() + 40)
                    Spacer()
                } else {
                    List {
                        ForEach(vm.articles) { article in
                            FavoriteArticleCardView(
                                imageName: article.imageName,
                                title: article.title,
                                description: article.content,
                                category: article.category,
                                readTime: article.readTimeText,
                                onRemove: nil,
                                isResultsSerachView: true,
                                onTap: {
                                    onArticleTap(article.id)
                                }
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                                for index in indexSet {
                                    let article = vm.articles[index]
                                    vm.removeFromFavorites(article.id)
                                }
                            }
                        
                        ClearAllButton {
                            vm.clearAllFavorites()
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .padding(.bottom, getSafeAreaBottom() + 50)
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.plain)
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ClearAllButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text("Clear All")
                    .font(.customInriaSans(.regular, size: 20))
                    .foregroundStyle(.beigeApp)
                
                Image(systemName: "trash.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 20)
                    .foregroundStyle(.beigeApp)
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                Capsule()
                    .fill(Color.redAppColor)
                    .shadow(radius: 4, x: 0, y: 4)
            )
        }
        .padding(.horizontal)
    }
}
