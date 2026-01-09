//
//  SearchView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct SearchView: View {
    let isFavoritesEmpty: Bool = true
    @State private var searchText = ""
    
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
                        Image("searchLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 50)
                    }
                    .padding(.top, getSafeAreaTop())
                    .padding()
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.brownApp)
                            .font(.system(size: 20, weight: .medium))
                        
                        
                        TextField("Search topics, tribes, years...", text: $searchText)
                            .font(.customInriaSans(.light, size: 16))
                            .foregroundColor(.brownApp)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: 50)
                    .background(
                        Capsule()
                            .fill(.beigeAppCat)
                            .overlay(
                                Capsule()
                                    .stroke((Color.brownApp).opacity(0.3), lineWidth: 1)
                            )
                    )
                    if isFavoritesEmpty {
                        Spacer()
                        EmptyView(isFavorites: true, title: "No matches. Try removing filters.", buttonTitle: "BACK")
                            .padding(.bottom, getSafeAreaBottom() + 40)
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading){
                                Text("Latest requests")
                                    .font(.customInriaSans(.bold, size: 16))
                                    .foregroundStyle(.brownApp)
                                    .padding(.top)
                                LastSearchView(title: "Species")
                                LastSearchView(title: "Timeline")
                                LastSearchView(title: "Before 1800")
                                
                                Text("Categories")
                                    .font(.customInriaSans(.bold, size: 16))
                                    .foregroundStyle(.brownApp)
                                    .padding(.top)
                                
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
                                
                                Text("Period")
                                    .font(.customInriaSans(.bold, size: 16))
                                    .foregroundStyle(.brownApp)
                                    .padding(.top)
                                
                                HStack {
                                    PeriodSerachView(title: "Before 1800")
                                    PeriodSerachView(title: "1800 - 1900")
                                    PeriodSerachView(title: "1900 - 1950")
                                    PeriodSerachView(title: "1500 - now")
                                }
                                
                                Text("Tags")
                                    .font(.customInriaSans(.bold, size: 16))
                                    .foregroundStyle(.brownApp)
                                    .padding(.top)
                                
                                LazyVGrid(
                                    columns: [
                                        GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())
                                    ],
                                    spacing: 16
                                ) {
                                    TagsSerachView(title: "#WildLife")
                                    TagsSerachView(title: "#Symbol of Strength")
                                    TagsSerachView(title: "#Prairies")
                                    TagsSerachView(title: "#HistoryofBison")
                                    TagsSerachView(title: "#Myths")
                                    TagsSerachView(title: "#IndigenousPeoples")
                                    TagsSerachView(title: "#NatureProtection")
                                    TagsSerachView(title: "#Biodiversity")
                                    TagsSerachView(title: "#Hoofprint")
                                }
                                
                                HStack {
                                    Button {
                                        //
                                    } label: {
                                        Text("Reset")
                                            .font(.customInriaSans(.regular, size: 18))
                                            .foregroundStyle(.brownAppCat)
                                            .padding()
                                            .frame(maxWidth: 100)
                                            .background(
                                                Capsule()
                                                    .fill(.beigeApp)
                                                    .overlay(
                                                        Capsule()
                                                            .stroke((Color.brownAppCat).opacity(0.3), lineWidth: 1)
                                                    )
                                                    .shadow(radius: 4, x: 0, y: 4)
                                            )
                                    }
                                    
                                    Button {
                                        //
                                    } label: {
                                        Text("Apply")
                                            .font(.customInriaSans(.regular, size: 18))
                                            .foregroundStyle(.beigeApp)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Capsule()
                                                    .fill(.brownAppCat)
                                                    .overlay(
                                                        Capsule()
                                                            .stroke((Color.brownAppCat).opacity(0.3), lineWidth: 1)
                                                    )
                                                    .shadow(radius: 4, x: 0, y: 4)
                                            )
                                    }
                                }
                                .padding()
                            }
                        }
                        .padding(.bottom, getSafeAreaBottom())
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}

struct TagsSerachView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.customInriaSans(.light, size: 14))
                .foregroundStyle(.brownApp)
                .lineLimit(1)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, minHeight: 40)
        .background(
            Capsule()
                .fill(.beigeAppCat)
                .overlay(
                    Capsule()
                        .stroke((Color.brownApp).opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct PeriodSerachView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.customInriaSans(.light, size: 10))
                .foregroundStyle(.brownApp)
                .lineLimit(1)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, minHeight: 40)
        .background(
            Capsule()
                .fill(.gray.opacity(0.5))
                .overlay(
                    Capsule()
                        .stroke((Color.brownApp).opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct LastSearchView: View {
    let title: String
    var body: some View {
        HStack() {
            Image(systemName: "clock.fill")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 20)
                .foregroundStyle(.brownApp)
            
            Text(title)
                .font(.customInriaSans(.regular, size: 18))
                .foregroundStyle(.brownApp)
            
            Spacer()
            
            Button {
                //
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.brownApp)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, minHeight: 40)
        .background(
            Capsule()
                .fill(.beigeAppCat)
                .overlay(
                    Capsule()
                        .stroke((Color.beigeApp).opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    SearchView()
}
