//
//  StatsView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct StatsView: View {
    
    
    @ObservedObject var vm: StatsViewModel
    let onCategoryTap: ([Article]) -> Void
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Image("statsLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 50)
                    Spacer()
                }
                .padding(.top, getSafeAreaTop())
                .padding()
                
                HStack(spacing: 12) {
                    ForEach(StatsPeriod.allCases, id: \.self) { period in
                        FilterButton(
                            title: period.rawValue,
                            isSelected: vm.selectedPeriod == period
                        ) {
                            vm.selectedPeriod = period
                        }
                    }
                }
                .padding(.horizontal)
                
                if vm.isEmpty {
                    Spacer()
                    EmptyView(title: "Start reading to see stats.")
                        .padding(.bottom, getSafeAreaBottom() + 40)
                    Spacer()
                } else {
                    VStack(spacing: 16) {
                        HStack {
                            VStack{
                                HStack {
                                    Text("Articles read")
                                        .font(.customInriaSans(.bold, size: 16))
                                        .foregroundStyle(.beigeApp)
                                    Spacer()
                                }
                                Spacer()
                                Text("\(vm.articlesRead)")
                                    .font(.customInriaSans(.bold, size: 24))
                                    .foregroundStyle(.beigeApp)
                                Text("Articles")
                                    .font(.customInriaSans(.bold, size: 24))
                                    .foregroundStyle(.beigeApp)
                                Spacer()
                                HStack {
                                    Image(systemName: "arrow.up.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 10)
                                        .foregroundStyle(.beigeApp)
                                    
                                    Text("+4 from last week")
                                        .font(.customInriaSans(.bold, size: 14))
                                        .foregroundStyle(.beigeApp)
                                }
                                
                            }
                            .padding()
                            .frame(maxHeight: 160)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.brownAppFav)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.brownApp.opacity(0.5))
                            )
                            
                            VStack {
                                HStack {
                                    Text("Reading time")
                                        .font(.customInriaSans(.bold, size: 16))
                                        .foregroundStyle(.beigeApp)
                                    Image(systemName: "clock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 10)
                                        .foregroundStyle(.beigeApp)
                                    Spacer()
                                }
                                Spacer()
                                Text("\(vm.readingTimeMinutes) minutes")
                                    .font(.customInriaSans(.bold, size: 24))
                                    .foregroundStyle(.beigeApp)
                                
                                Spacer()
                                Text("All time this week")
                                    .font(.customInriaSans(.bold, size: 14))
                                    .foregroundStyle(.beigeApp)
                                
                            }
                            .padding()
                            .frame(maxHeight: 160)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.brownAppFav)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.brownApp.opacity(0.5))
                            )
                        }
                        VStack {
                            HStack {
                                Text("Top categories")
                                    .font(.customInriaSans(.bold, size: 20))
                                    .foregroundStyle(.beigeApp)
                                Spacer()
                                Image("chart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 40)
                                    .foregroundStyle(.beigeApp)
                            }
                            Divider()
                                .frame(height: 2)
                                .background(.beigeApp)
                            
                            ForEach(vm.topCategories) { category in
                                VStack(spacing: 8) {
                                    HStack {
                                        Text(category.title)
                                            .font(.customInriaSans(.regular, size: 18))
                                            .foregroundStyle(.beigeApp)

                                        Spacer()

                                        Text("\(category.readCount) articles")
                                            .font(.customInriaSans(.regular, size: 18))
                                            .foregroundStyle(.beigeApp)
                                    }

                                    ProgressView(value: category.progress)
                                        .progressViewStyle(.linear)
                                        .tint(.brownAppCat)
                                        .background(.beigeApp)
                                        .scaleEffect(x: 1, y: 2)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    let articles = vm.getArticles(for: category.id)
                                    onCategoryTap(articles)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.brownAppFav)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.brownApp.opacity(0.5))
                        )
                    }
                    .padding()
                }
                Spacer()
            }
            
            
        }
        .navigationBarHidden(true)
        .id(vm.topCategories.count)
    }
}

