//
//  ResultsSearchView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct ResultsSearchView: View {
    
    @StateObject private var vm: ResultsSearchViewModel
    
    let onArticleTap: (String) -> Void
    let onBackTap: () -> Void
    
    init(articleIDs: [String], repository: ArticlesRepository, onArticleTap: @escaping (String) -> Void, onBackTap: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: ResultsSearchViewModel(repository: repository, articleIDs: articleIDs))
        self.onArticleTap = onArticleTap
        self.onBackTap = onBackTap
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Button {
                        onBackTap()
                    } label: {
                        Image("backButton")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 40)
                    }
                    
                    Spacer()
                    Image("resultsLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 50)
                }
                .padding(.top, getSafeAreaTop())
                .padding()
                VStack(alignment: .leading) {
                    Menu {
                        ForEach(vm.sortOptions, id: \.self) { option in
                            Button {
                                vm.updateSort(to: option)
                            } label: {
                                HStack {
                                    Text(option)
                                    if vm.selectedSort == option {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text("Sort by: \(vm.selectedSort)")
                                .font(.customInriaSans(.regular, size: 18))
                                .foregroundStyle(.brownApp)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.brownApp)
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: 250, maxHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.brownApp, lineWidth: 1.5)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.beigeAppCat)
                                )
                        )
                        .padding(.bottom, 4)
                    }
                    ScrollView(showsIndicators: false) {
                        
                        LazyVStack(spacing: 16) {
                            ForEach(vm.articles, id: \.id) { article in
                                FavoriteArticleCardView(
                                    imageName: article.coverImage ?? "1",
                                    title: article.title,
                                    description: article.content,
                                    category: article.category,
                                    readTime: "\(article.readTime)",
                                    onRemove: nil,
                                    isResultsSerachView: true,
                                    onTap: {
                                        onArticleTap(article.id)
                                    }
                                )
                            }
                        }
                    }
                    .padding(.bottom, getSafeAreaBottom())
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}
