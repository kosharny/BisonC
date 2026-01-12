//
//  FilterButton.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

enum HistoryPeriod: String, CaseIterable {
    case today = "Today"
    case week = "7 days"
    case month = "30 days"
    case all = "All"
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool 
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.customInriaSans(.regular, size: 14))
                .foregroundStyle(isSelected ? .beigeApp : .brownApp)
                .padding(.horizontal, 10)
                .frame(minWidth: 70, minHeight: 40)
                .background(
                    Capsule()
                        .fill(isSelected ? .brownAppCat : .beigeAppCat)
                )
                .overlay(
                    Capsule()
                        .stroke(Color.beigeApp.opacity(0.5))
                )
        }
        .animation(.spring(), value: isSelected)
    }
}
