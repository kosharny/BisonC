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
                .foregroundStyle(.darkTextTitleApp)
                .lineLimit(2)
            
            Text(readTime)
                .font(.customInriaSans(.light, size: 16))
                .foregroundStyle(.darkTextTitleApp)
            
            HStack {
                CategoryTagView(title: category)
                
                Spacer()
                
                Button {
                    // toggle favorite
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(.brownAppCat)
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.beigeApp)
                .shadow(radius: 4, x: 0, y: 4)
        )
        .frame(width: 260)
    }
}


