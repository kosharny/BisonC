//
//  HomeView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel
    
    init(
        container: NSPersistentContainer,
        onSearchTap: @escaping () -> Void,
        onArticleTap: @escaping (String) -> Void,
        onCategoryTap: @escaping ([String]) -> Void
    ) {
        _vm = StateObject(
            wrappedValue: HomeViewModel(
                repository: ArticlesRepositoryCoreData(container: container)
            )
        )
        self.onSearchTap = onSearchTap
        self.onArticleTap = onArticleTap
        self.onCategoryTap = onCategoryTap
    }
    
    
    let onSearchTap: () -> Void
    let onArticleTap: (String) -> Void
    let onCategoryTap: ([String]) -> Void
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Image("mainLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 50)
                    Spacer()
                    Button {
                        onSearchTap()
                    } label: {
                        Image("searchButton")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50)
                    }
                }
                .padding(.top, getSafeAreaTop())
                .padding()
                
                ScrollView(showsIndicators: false) {
                    if let hero = vm.heroArticle {
                        Button {
                            onArticleTap(hero.id)
                        } label: {
                            ZStack(alignment: .bottomLeading) {
                                Image(hero.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 220)
                                    .clipped()
                                
                                LinearGradient(
                                    colors: [
                                        Color.black.opacity(0.65),
                                        Color.black.opacity(0.2),
                                        Color.clear
                                    ],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(hero.title)
                                        .font(.customPlayfairDisplay(.bold, size: 20))
                                        .foregroundStyle(.beigeApp)
                                    
                                    Text(hero.summary)
                                        .font(.customInriaSans(.light, size: 16))
                                        .foregroundStyle(.beigeApp)
                                    
                                    Button("Start reading") {
                                        onArticleTap(hero.id)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.brownAppCat)
                                    .controlSize(.regular)
                                }
                                .padding(16)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .padding()
                        }
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("Quick access")
                            .font(.customInriaSans(.bold, size: 16))
                            .foregroundStyle(.brownApp)
                            .padding(.horizontal)
                        
                        HStack(alignment: .top) {
                            QuickAccessItemView(
                                title: "Timeline",
                                icon: Image("timeline")
                            )
                            
                            QuickAccessItemView(
                                title: "Tribes & Culture",
                                icon: Image("tribes")
                            )
                            
                            QuickAccessItemView(
                                title: "Conservation",
                                icon: Image("conservation")
                            )
                            
                            QuickAccessItemView(
                                title: "Species",
                                icon: Image("species")
                            )
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Categories")
                            .font(.customInriaSans(.bold, size: 16))
                            .foregroundStyle(.brownApp)
                        
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ],
                            spacing: 16
                        ) {
                            ForEach(vm.categories) { category in
                                CategoryPillView(
                                    title: category.title,
                                    icon: Image(category.icon)
                                )
                                .onTapGesture {
                                    onCategoryTap([category.id])
                                }
                            }
                        }
                        
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        
                        Text("Popular/Recommended")
                            .font(.customInriaSans(.bold, size: 16))
                            .foregroundStyle(.brownApp)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(vm.popularArticles) { article in
                                    ArticleCardView(
                                        image: Image(article.imageName),
                                        title: article.title,
                                        readTime: article.readTimeText,
                                        category: article.category,
                                        isFavorite: article.isFavorite,
                                        onTap: {
                                            onArticleTap(article.id)
                                        }
                                    )
                                }
                            }
                        }
                    }
                    .padding(.leading)
                    .padding(.bottom)
                }
                .padding(.bottom, getSafeAreaBottom() + 30)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            vm.load()
        }
    }
}

//#Preview {
//    HomeView(onSearchTap: {}, onArticleTap: {_ in })
//}










