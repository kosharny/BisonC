//
//  ContentView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Image("appBackground")
                .resizable()
                .scaledToFill()
            Text("PlayfairDisplaySC")
                .font(.customPlayfairDisplaySC(.bold, size: 24))
                .foregroundStyle(.darkTextApp)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
