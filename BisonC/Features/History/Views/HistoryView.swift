//
//  HistoryView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct HistoryView: View {
    
    @State private var isFiltered: Bool = false
    let isHistoryEmpty: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Image("historyLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 50)
                        Spacer()
                    }
                    .padding(.top, getSafeAreaTop())
                    .padding()
                    
                    HStack {
                        FilterButton(isFiltered: $isFiltered, title: "Today")
                        FilterButton(isFiltered: $isFiltered, title: "7 days")
                        FilterButton(isFiltered: $isFiltered, title: "30 days")
                        FilterButton(isFiltered: $isFiltered, title: "All")
                    }
                    
                    if isHistoryEmpty {
                        Spacer()
                        EmptyView(title: "Your reading history will appear here.")
                            .padding(.bottom, getSafeAreaBottom() + 40)
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            CardHistoryView()
                            CardHistoryView()
                            CardHistoryView()
                            
                            Button {
                                //
                            } label: {
                                Image("exportButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 50)
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
    HistoryView()
}
