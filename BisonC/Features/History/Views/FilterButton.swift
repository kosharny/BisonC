//
//  FilterButton.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct FilterButton: View {
    @Binding var isFiltered: Bool
    let title: String
    var body: some View {
        Button {
            isFiltered.toggle()
        } label: {
            Text(title)
                .font(.customInriaSans(.regular, size: 16))
                .foregroundStyle(isFiltered ? .beigeApp : .brownApp)
                .padding()
                .frame(minWidth: 80)
                .background(
                    Capsule()
                        .fill(isFiltered ? .brownAppCat : .beigeAppCat)
                )
                .overlay(
                    Capsule()
                        .stroke(Color.beigeApp.opacity(0.5))
                )
        }
    }
}
