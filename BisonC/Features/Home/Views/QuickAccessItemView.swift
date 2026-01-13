//
//  QuickAccessItemView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct QuickAccessItemView: View {
    let title: String
    let icon: Image
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(.brownApp)
                        .frame(width: 64, height: 64)
                    
                    Circle()
                        .fill(.beigeApp)
                        .frame(width: 44, height: 44)
                    
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }
                
                Text(title)
                    .font(.customInriaSans(.regular, size: 14))
                    .foregroundStyle(.brownApp)
                    .lineLimit(1)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity)
        }
    }
}
