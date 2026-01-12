//
//  StatsView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct StatsView: View {
    
    @State private var isFiltered: Bool = false
    let isStatsEmpty: Bool = false
    
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
                
                HStack {
//                    FilterButton(isFiltered: $isFiltered, title: "Week")
//                    FilterButton(isFiltered: $isFiltered, title: "Month")
//                    FilterButton(isFiltered: $isFiltered, title: "All")
                }
                
                if isStatsEmpty {
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
                                Text("14")
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
                                        .font(.customInriaSans(.bold, size: 16))
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
                                Text("40 minutes")
                                    .font(.customInriaSans(.bold, size: 24))
                                    .foregroundStyle(.beigeApp)
                                
                                Spacer()
                                Text("All time this week")
                                    .font(.customInriaSans(.bold, size: 16))
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
                            
                            HStack {
                                Text("Timeline")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.beigeApp)
                                Spacer()
                                Text("9 articles")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.beigeApp)
                            }
                            ProgressView(value: 0.7)
                                .progressViewStyle(.linear)
                                .tint(.brownAppCat)
                                .background(.beigeApp)
                                .scaleEffect(x: 1, y: 2)
                            HStack {
                                Text("Myths & Facts")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.beigeApp)
                                Spacer()
                                Text("2 articles")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.beigeApp)
                            }
                            ProgressView(value: 0.3)
                                .progressViewStyle(.linear)
                                .tint(.brownAppCat)
                                .background(.beigeApp)
                                .scaleEffect(x: 1, y: 2)
                            HStack {
                                Text("Conservation")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.beigeApp)
                                Spacer()
                                Text("3 articles")
                                    .font(.customInriaSans(.regular, size: 18))
                                    .foregroundStyle(.beigeApp)
                            }
                            ProgressView(value: 0.4)
                                .progressViewStyle(.linear)
                                .tint(.brownAppCat)
                                .background(.beigeApp)
                                .scaleEffect(x: 1, y: 2)
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
    }
}

#Preview {
    StatsView()
}
