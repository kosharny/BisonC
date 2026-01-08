//
//  CategoryTagView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct CategoryTagView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.customInriaSans(.regular, size: 14))
            .foregroundStyle(.beigeApp)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(.brownAppFav)
            )
            .overlay(
                Capsule()
                    .stroke(Color.brownApp.opacity(0.5))
            )
    }
}
