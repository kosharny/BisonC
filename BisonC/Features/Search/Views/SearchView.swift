//
//  SearchView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var keyboard = KeyboardResponder()
    @StateObject var vm: SearchViewModel
    let isFavoritesEmpty: Bool = false
    let onBackTap: () -> Void
    let onSearch: ([Article]) -> Void
    
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
                    
                    
                    TextField("Search topics, tribes, years...", text: $vm.searchText)
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
                .padding(.horizontal)
                
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
                            if !vm.history.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(vm.history.prefix(5), id: \.self) { query in
                                        HStack {
                                            Button {
                                                vm.searchText = query
                                            } label: {
                                                LastSearchView(title: query)
                                            }
                                            
                                            Button {
                                                vm.removeHistoryItem(query)
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundStyle(.brownApp)
                                                    .font(.system(size: 20))
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .background(
                                            Capsule()
                                                .fill(.beigeAppCat)
                                                .overlay(
                                                    Capsule()
                                                        .stroke(Color.beigeApp.opacity(0.3), lineWidth: 1)
                                                )
                                        )
                                    }
                                }
                            }

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
                                ForEach(vm.categories) { category in
                                    CategoryPillView(
                                        title: category.title,
                                        icon: Image(category.icon)
                                    )
                                    .opacity(vm.selectedCategories.contains(category.id) ? 1.0 : 0.5)
                                    .onTapGesture {
                                        vm.toggleCategory(category.id)
                                    }
                                }
                            }
                            
                            Text("Period")
                                .font(.customInriaSans(.bold, size: 16))
                                .foregroundStyle(.brownApp)
                                .padding(.top)
                            
                            HStack {
                                LazyVGrid(
                                    columns: [
                                        GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())
                                    ],
                                    spacing: 16
                                ) {
                                    ForEach(vm.periods, id: \.self) { period in
                                        PeriodSerachView(title: period)
                                            .opacity(vm.selectedPeriods.contains(period) ? 1.0 : 0.5)
                                            .onTapGesture {
                                                vm.togglePeriod(period)
                                            }
                                    }
                                }
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
                                ForEach(vm.tags, id: \.self) { tag in
                                    TagsSerachView(title: "#\(tag)")
                                        .opacity(vm.selectedTags.contains(tag) ? 1.0 : 0.5)
                                        .onTapGesture {
                                            vm.toggleTag(tag)
                                        }
                                }
                            }
                            
                            HStack {
                                Button {
                                    vm.resetFilters()
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
                                    let results = vm.filteredArticles()
                                    onSearch(results)
                                    vm.resetFilters()
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
                    .padding(.horizontal)
                    .padding(.bottom, getSafeAreaBottom())
                }
                Spacer(minLength: keyboard.currentHeight)
            }
            .animation(.easeOut(duration: 0.25), value: keyboard.currentHeight)
            .navigationBarHidden(true)
            .toolbar(.hidden, for: .tabBar)
        }
        .hideKeyboardOnTap()
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
        HStack {
            Image(systemName: "clock.fill")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 20)
                .foregroundStyle(.brownApp)
            
            Text(title)
                .font(.customInriaSans(.regular, size: 18))
                .foregroundStyle(.brownApp)
            
            Spacer()
        }
//        .padding(.horizontal)
//        .frame(maxWidth: .infinity, minHeight: 40)
//        .background(
//            Capsule()
//                .fill(.beigeAppCat)
//                .overlay(
//                    Capsule()
//                        .stroke(Color.beigeApp.opacity(0.3), lineWidth: 1)
//                )
//        )
    }
}


//#Preview {
//    SearchView(onBackTap: { }, onSearch: { _ in })
//}
