//
//  CategoryPillView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//


import SwiftUI

struct CategoryPillView: View {
    let title: String
    let icon: Image
    
    var body: some View {
        HStack() {
            
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(.customInriaSans(.regular, size: 12))
                .foregroundStyle(.brownApp)
                .lineLimit(2)
            
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.beigeAppCat)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.brownApp.opacity(0.5))
                )
        )
    }
}
