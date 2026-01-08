//
//  HomeView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
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
                        
                        ZStack(alignment: .bottomLeading) {
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
                                
                                Text("Explore the comprehensive history and life of the American bison.")
                                    .font(.customInriaSans(.light, size: 16))
                                    .foregroundStyle(.beigeApp)
                                
                                Button("Start reading") {
                                    // action
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
                                CategoryPillView(title: "Species", icon: Image("speciesCat"))
                                CategoryPillView(title: "Timeline", icon: Image("timelineCat"))
                                CategoryPillView(title: "Places", icon: Image("placesCat"))
                                CategoryPillView(title: "Culture & Tribes", icon: Image("cultureCat"))
                                CategoryPillView(title: "Conservation", icon: Image("conservationCat"))
                                CategoryPillView(title: "Myths & Facts", icon: Image("mythsCat"))
                            }
                            
                        }
                        .padding()
                        VStack(alignment: .leading) {
                            
                            Text("Popular/Recommended")
                                .font(.customInriaSans(.bold, size: 16))
                                .foregroundStyle(.brownApp)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ArticleCardView(
                                        image: Image("1"),
                                        title: "Bison in the culture of indigenous peoples",
                                        readTime: "7 minutes to read",
                                        category: "Culture & Tribes",
                                        isFavorite: false
                                    )
                                    ArticleCardView(
                                        image: Image("1"),
                                        title: "Bison in the culture of indigenous peoples",
                                        readTime: "7 minutes to read",
                                        category: "Culture & Tribes",
                                        isFavorite: false
                                    )
                                    ArticleCardView(
                                        image: Image("1"),
                                        title: "Bison in the culture of indigenous peoples",
                                        readTime: "7 minutes to read",
                                        category: "Culture & Tribes",
                                        isFavorite: false
                                    )
                                    ArticleCardView(
                                        image: Image("1"),
                                        title: "Bison in the culture of indigenous peoples",
                                        readTime: "7 minutes to read",
                                        category: "Culture & Tribes",
                                        isFavorite: false
                                    )
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
        }
    }
}

#Preview {
    HomeView()
}










