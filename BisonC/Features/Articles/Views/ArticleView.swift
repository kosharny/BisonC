//
//  ArticleView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 10.01.2026.
//

import SwiftUI

struct ArticleView: View {
    @State var isFavorite: Bool = false
    let articleId: String
    let onBackTap: () -> Void
    
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
                        isFavorite.toggle()
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 30)
                            .foregroundStyle(.brownApp)
                    }
                }
                .padding(.top, getSafeAreaTop())
                .padding()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topLeading) {
                            Image("1")
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
                                Text("Bison: The Full Story")
                                    .font(.customPlayfairDisplay(.bold, size: 20))
                                    .foregroundStyle(.beigeApp)
                                
                                Spacer()
                                
                                HStack {
                                    CategoryTagView(title: "Timeline")
                                        .frame(minHeight: 50)
                                    CategoryTagView(title: "1800-1900")
                                        .frame(minHeight: 50)
                                    Spacer()
                                    
                                    Text("5 minutes to read")
                                        .font(.customInriaSans(.light, size: 14))
                                        .foregroundStyle(.beigeApp)
                                }
                            }
                            .padding(16)
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        
                        CategoryTagView(title: "#NatureProtection")
                        CategoryTagView(title: "#HistoryofBison")
                        CategoryTagView(title: "#Prairies")
                        VStack(alignment: .leading, spacing: 25) {
                            ArticleSection(title: "INTRODUCTION", content: "In the 19th century, the American prairies were home to millions of bison. For indigenous peoples, they were a source of food, clothing and spiritual strength...", activeIndex: 0)
                            
                            ArticleSection(title: "DETAILS", content: "In the 19th century, the American prairies were home to millions of bison. For indigenous peoples, they were a source of food, clothing and spiritual strength...", activeIndex: 1)
                            
                            ArticleSection(title: "PROBLEM", content: "The disappearance of bison was a blow to the ecosystem: the vegetation, the balance of animals and the cultural life of the tribes changed...", activeIndex: 2)
                            
                            ArticleSection(title: "CONCLUSION", content: "Today, the bison is a symbol of strength and national identity. His story reminds us: disappearance can be quick, and restoration requires ten years of effort.", activeIndex: 3)
                        }
                        
                        ReadyButton {
                            onBackTap()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, getSafeAreaBottom())
            }
            .navigationBarHidden(true)
            .toolbar(.hidden, for: .tabBar)
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

#Preview {
    ArticleView(articleId: "", onBackTap: { })
}
