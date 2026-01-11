//
//  FavoriteArticleCardView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct FavoriteArticleCardView: View {
    
    let imageName: String
    let title: String
    let description: String
    let category: String
    let readTime: String
    
    let onRemove: (() -> Void)?
    
    var isResultsSerachView = false
    
    let onTap: () -> Void
    
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 0) {
                
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(title)
                        .font(.customInriaSans(.bold, size: 20))
                        .foregroundStyle(.darkTextApp)
                    
                    Text(description)
                        .font(.customInriaSans(.light, size: 14))
                        .foregroundStyle(.darkTextApp)
                        .lineLimit(2)
                    
                    HStack {
                        
                        CategoryTagView(title: category)
                            .frame(minWidth: 80, minHeight: 40)
                        
                        Spacer()
                        
                        Text("\(readTime) minutes to read")
                            .font(.customInriaSans(.light, size: 12))
                            .foregroundStyle(.darkTextApp)
                    }
                    HStack {
                        Spacer()
                        if isResultsSerachView {
                            Button(action: onTap) {
                                
                                HStack {
                                    Text("View details")
                                        .font(.customInriaSans(.bold, size: 14))
                                        .foregroundStyle(.brownApp)
                                    
                                    Image(systemName: "arrow.right")
                                        .foregroundStyle(.brownApp)
                                }
                                .padding()
                                .background(
                                    Capsule()
                                        .fill(Color.brownApp.opacity(0.2))
                                )
                            }
                        } else if let onRemove {
                            Button(action: onRemove) {
                                
                                HStack {
                                    Text("Remove From Favorites")
                                        .font(.customInriaSans(.bold, size: 14))
                                        .foregroundStyle(.beigeApp)
                                    
                                    Image(systemName: "trash.circle.fill")
                                        .foregroundStyle(.beigeApp)
                                }
                                .padding()
                                .background(
                                    Capsule()
                                        .fill(Color.redAppColor.opacity(0.5))
                                )
                            }
                        }
                    }
                    
                    
                    
                    Spacer(minLength: 0)
                }
                .padding(16)
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.beigeAppCat)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.beigeApp.opacity(0.5))
            )
        }
    }
}
