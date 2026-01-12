//
//  ArticleView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 10.01.2026.
//

import SwiftUI

struct ArticleView: View {
    
    @StateObject private var vm: ArticleViewModel
    
    let articleId: String
    let onBackTap: () -> Void
    
    init(articleId: String, repository: ArticlesRepository, onBackTap: @escaping () -> Void) {
        self.articleId = articleId
        self.onBackTap = onBackTap
        _vm = StateObject(wrappedValue: ArticleViewModel(articleId: articleId, repository: repository))
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
                    Button {
                        vm.toggleFavorite()
                    } label: {
                        Image(systemName: (vm.article?.isFavorite ?? false) ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 30)
                            .foregroundStyle(.brownApp)
                    }
                }
                .padding(.top, getSafeAreaTop())
                .padding()
                ScrollView(showsIndicators: false) {
                    if let article = vm.article {
                        VStack(alignment: .leading) {
                            ZStack(alignment: .topLeading) {
                                Image(article.imageName)
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
                                    Text(article.title)
                                        .font(.customPlayfairDisplay(.bold, size: 20))
                                        .foregroundStyle(.beigeApp)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        CategoryTagView(title: article.category)
                                            .frame(minHeight: 50)
                                        if let period = article.yearPeriod, !period.isEmpty {
                                            CategoryTagView(title: period)
                                                .frame(minHeight: 50)
                                        }
                                        Spacer()
                                        
                                        Text(article.readTimeText)
                                            .font(.customInriaSans(.light, size: 14))
                                            .foregroundStyle(.beigeApp)
                                    }
                                }
                                .padding(16)
                                
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            
                            ForEach(article.tags, id: \.self) { tag in
                                    CategoryTagView(title: "#\(tag)")
                                }
                            VStack(alignment: .leading, spacing: 25) {
                                ArticleSection(title: "INTRODUCTION", content: article.intro, activeIndex: 0)
                                
                                ArticleSection(title: "DETAILS", content: article.details, activeIndex: 1)
                                
                                ArticleSection(title: "PROBLEM", content: article.problem, activeIndex: 2)
                                
                                ArticleSection(title: "CONCLUSION", content: article.conclusion, activeIndex: 3)
                            }
                            
                            ReadyButton {
                                onBackTap()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, getSafeAreaBottom())
            }
            .navigationBarHidden(true)
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                vm.load()
            }
        }
    }
}

struct ReadyButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text("Ready")
                    .font(.customInriaSans(.regular, size: 20))
                    .foregroundStyle(.beigeApp)
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 20)
                    .foregroundStyle(.beigeApp)
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                Capsule()
                    .fill(Color.brownAppCat)
                    .shadow(radius: 4, x: 0, y: 4)
            )
        }
        .padding(.horizontal)
    }
}

struct ArticleSection: View {
    let title: String
    let content: String
    let activeIndex: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 15) {
                Text(title)
                    .font(.customPlayfairDisplaySC(.bold, size: 18))
                    .foregroundStyle(.brownApp)
                
                DecorativeLine(activeIndex: activeIndex)
            }
            
            Text(content)
                .font(.customInriaSans(.regular, size: 14))
                .foregroundColor(.darkTextApp)
                .lineSpacing(4)
        }
    }
}

struct DecorativeLine: View {
    let activeIndex: Int
    let activeColor: Color = Color.yellowAppColor
    let inactiveColor: Color = Color.brownApp
    
    var body: some View {
        HStack(spacing: 8) {
            Capsule()
                .fill(activeIndex == 0 ? activeColor : inactiveColor)
                .frame(width: 80, height: 4)
            
            ForEach(1..<4) { index in
                Capsule()
                    .fill(activeIndex == index ? activeColor : inactiveColor)
                    .frame(width: 25, height: 4)
            }
        }
    }
}


