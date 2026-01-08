//
//  FavoritesView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct FavoritesView: View {
    let isFavoritesEmpty: Bool = true
    
    var body: some View {
        NavigationStack {
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
                    if isFavoritesEmpty {
                        Spacer()
                        EmptyView(isFavorites: true)
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            FavoriteArticleCardView(
                                imageName: "1",
                                title: "Bison in culture.",
                                description: "Discover the secret of rituals and legends where the bison was the center...",
                                category: "Culture & Tribes",
                                readTime: "10 minutes to read",
                                onRemove: {
                                    print("Remove tapped")
                                }
                            )
                            FavoriteArticleCardView(
                                imageName: "1",
                                title: "Bison in culture.",
                                description: "Discover the secret of rituals and legends where the bison was the center...",
                                category: "Culture & Tribes",
                                readTime: "10 minutes to read",
                                onRemove: {
                                    print("Remove tapped")
                                }
                            )
                            FavoriteArticleCardView(
                                imageName: "1",
                                title: "Bison in culture.",
                                description: "Discover the secret of rituals and legends where the bison was the center...",
                                category: "Culture & Tribes",
                                readTime: "10 minutes to read",
                                onRemove: {
                                    print("Remove tapped")
                                }
                            )
                            
                            ClearAllButton {
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, getSafeAreaBottom() + 50)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    FavoritesView()
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
