//
//  ResultsSearchView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct ResultsSearchView: View {
    @State private var selectedSort = "Most relevant"
    let sortOptions = ["Most relevant", "Newest", "Oldest", "A-Z"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Button {
                            
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
                            ForEach(sortOptions, id: \.self) { option in
                                            Button {
                                                selectedSort = option
                                            } label: {
                                                Text(option)
                                                if selectedSort == option {
                                                    Image(systemName: "checkmark")
                                                }
                                            }
                                        }
                        } label: {
                            HStack {
                                Text("Sort by: \(selectedSort)")
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
                            FavoriteArticleCardView(
                                imageName: "1",
                                title: "Bison in culture.",
                                description: "Discover the secret of rituals and legends where the bison was the center...",
                                category: "Culture & Tribes",
                                readTime: "10 minutes to read",
                                onRemove: {
                                    print("Remove tapped")
                                },
                                isResultsSerachView: true
                            )
                            FavoriteArticleCardView(
                                imageName: "1",
                                title: "Bison in culture.",
                                description: "Discover the secret of rituals and legends where the bison was the center...",
                                category: "Culture & Tribes",
                                readTime: "10 minutes to read",
                                onRemove: {
                                    print("Remove tapped")
                                },
                                isResultsSerachView: true
                            )
                            FavoriteArticleCardView(
                                imageName: "1",
                                title: "Bison in culture.",
                                description: "Discover the secret of rituals and legends where the bison was the center...",
                                category: "Culture & Tribes",
                                readTime: "10 minutes to read",
                                onRemove: {
                                    print("Remove tapped")
                                },
                                isResultsSerachView: true
                            )
                            FavoriteArticleCardView(
                                imageName: "1",
                                title: "Bison in culture.",
                                description: "Discover the secret of rituals and legends where the bison was the center...",
                                category: "Culture & Tribes",
                                readTime: "10 minutes to read",
                                onRemove: {
                                    print("Remove tapped")
                                },
                                isResultsSerachView: true
                            )
                        }
                        .padding(.bottom, getSafeAreaBottom())
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ResultsSearchView()
}
