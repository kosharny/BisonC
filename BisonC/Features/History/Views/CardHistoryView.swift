//
//  CardHistoryView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct CardHistoryView: View {
    let title: String
    let readingDate: String
    let categorieName: String
    let progress: Double
    let isPurchased: Bool
    let onDelete: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.customInriaSans(.bold, size: 20))
                    .foregroundStyle(.darkTextApp)
                Text(readingDate)
                    .font(.customInriaSans(.light, size: 14))
                    .foregroundStyle(.darkTextApp)
            }
            
            HStack {
                CategoryTagView(title: categorieName)
                
                VStack(alignment: .trailing) {
                    Text("\(Int(progress))%")
                        .font(.customInriaSans(.light, size: 14))
                        .foregroundStyle(.darkTextApp)
                    ProgressView(value: min(max(progress / 100, 0), 1))
                        .progressViewStyle(.linear)
                        .tint(.brownApp)
                        .background(.brownApp.opacity(0.2))
                        .scaleEffect(x: 1, y: 2)
                }
            }
            .padding()
            
            Button {
                onDelete()
            } label: {
                ZStack {
                    HStack(spacing: 8) {
                        
                        Text("Delete Entry")
                            .font(.customInriaSans(.bold, size: 14))
                            .foregroundStyle(.beigeApp)
                        
                        Image(systemName: "trash.circle.fill")
                            .foregroundStyle(.beigeApp)
                        
                        
                        
                    }
                    if !isPurchased {
                        HStack {
                            Spacer()
                            Image("premiumLabel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 50)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(Color.redAppColor.opacity(0.5))
                )
            }
            .disabled(!isPurchased)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.beigeAppCat)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.beigeApp.opacity(0.5))
        )
    }
}
