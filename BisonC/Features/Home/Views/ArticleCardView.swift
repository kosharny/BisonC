//
//  ArticleCardView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct ArticleCardView: View {
    let image: Image
    let title: String
    let readTime: String
    let category: String
    let isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            image
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                )
                .clipped()
            
            Text(title)
                .font(.customInriaSans(.bold, size: 18))
                .foregroundStyle(.darkTextApp)
                .lineLimit(2)
            
            Text(readTime)
                .font(.customInriaSans(.light, size: 16))
                .foregroundStyle(.darkTextApp)
            
            HStack {
                CategoryTagView(title: category)
                
                Spacer()
                
                Button {
                    // toggle favorite
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(.brownApp)
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.beigeApp)
        )
        .frame(width: 260)
    }
}

struct CategoryTagView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.customInriaSans(.regular, size: 16))
            .foregroundStyle(.beigeApp)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.lightBrownAppColor)
            )
    }
}
