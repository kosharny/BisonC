//
//  HistoryView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI
import CoreData

struct HistoryView: View {

    @ObservedObject var vm: HistoryViewModel
//    @State private var isFiltered: Bool = false
    

    var body: some View {
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
                    ForEach(HistoryPeriod.allCases, id: \.self) { period in
                        FilterButton(
                            title: period.rawValue,
                            isSelected: vm.selectedPeriod == period
                        ) {
                            vm.selectedPeriod = period
                        }
                    }
                }
                .padding(.horizontal)
                

                if vm.filteredItems.isEmpty {
                    Spacer()
                    EmptyView(title: "Your reading history will appear here.")
                        .padding(.bottom, getSafeAreaBottom() + 40)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(vm.filteredItems) { item in
                            CardHistoryView(
                                title: item.article.title,
                                readingDate: item.entry.openedAt.formattedForHistory(),
                                categorieName: item.article.category,
                                progress: item.entry.progress,
                                onDelete: {
                                    vm.removeHistoryEntry(item.id)
                                }
                            )
                            .id(item.id)
                        }

                        Button {
                            // Экспорт истории или другая логика
                        } label: {
                            Image("exportButton")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 50)
                        }
                        .padding(.bottom, getSafeAreaBottom() + 50)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
