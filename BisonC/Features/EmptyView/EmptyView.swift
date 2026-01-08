//
//  EmptyView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct EmptyView: View {
    var isFavorites: Bool = false
    let title: String
    
    var body: some View {
        VStack {
            Image("emptyBg")
                .resizable()
                .scaledToFit()
            Text(title)
                .font(.customPlayfairDisplay(.bold, size: 20))
                .foregroundStyle(.brownApp)
            
            if isFavorites {
                Button {
                    //
                } label: {
                    Text("EXPLORE ARTICLES")
                        .font(.customPlayfairDisplaySC(.bold, size: 18))
                        .foregroundStyle(.brownApp)
                        .padding(8)
                        .background(
                            Capsule()
                                .fill(.beigeAppCat)
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.beigeApp.opacity(0.5))
                        )
                }
            }
        }
    }
}

#Preview {
    EmptyView(title: "No favorites yet")
}
