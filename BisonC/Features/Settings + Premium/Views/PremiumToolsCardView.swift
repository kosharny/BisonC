//
//  PremiumToolsCardView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 14.01.2026.
//

import SwiftUI

struct PremiumToolsCardView: View {
    let title: String
    let subtitle: String
    let price: String
    let isPurchased: Bool
    
    var onUnlockTap: () -> Void
    var onPrimaryActionTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Button {
                    onPrimaryActionTap()
                } label: {
                    Text(title)
                        .font(.customInriaSans(.bold, size: 16))
                        .foregroundStyle(.brownAppCat)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .disabled(!isPurchased)
                .blur(radius: !isPurchased ? 4 : 0)
                
                    Image("premiumLock")
                        .resizable()
                        .scaledToFit()
                        .opacity(!isPurchased ? 1 : 0)
                
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.customInriaSans(.bold, size: 18))
                        .foregroundStyle(.darkTextTitleApp)
                    
                    Text(subtitle)
                        .font(.customInriaSans(.light, size: 14))
                        .foregroundStyle(.darkTextTitleApp)
                        .opacity(0.8)
                }
                
                Spacer()
                
            }
            
            HStack {
                Text(price)
                    .font(.customInriaSans(.bold, size: 14))
                    .foregroundStyle(.darkTextTitleApp)
                
                Spacer()
                
                Button {
                    onUnlockTap()
                } label: {
                    Text("Unlock")
                        .font(.customInriaSans(.regular, size: 12))
                        .foregroundStyle(.beigeApp)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.brownAppCat)
                        )
                }
            }
            .padding(.top, 8)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.beigeApp)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.brownAppCat.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Preview
#Preview {
    HStack {
        // Пример 1: Заблокировано (Export)
        PremiumToolsCardView(
            title: "Export Data",
            subtitle: "Export your reading history to a file",
            price: "$1.99",
            isPurchased: false,
            onUnlockTap: { print("Unlock Export") },
            onPrimaryActionTap: {}
        )
        
        // Пример 2: Куплено (Reset)
        PremiumToolsCardView(
            title: "Reset History",
            subtitle: "Clear all history & stats with one tap",
            price: "$0.99",
            isPurchased: true,
            onUnlockTap: {},
            onPrimaryActionTap: { print("Resetting...") }
        )
    }
}
