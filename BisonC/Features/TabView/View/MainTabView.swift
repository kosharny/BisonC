//
//  MainTabView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("home")
                }
            
            FavoritesView()
                .tabItem {
                    Image("favorites")
                }
            
            HistoryView()
                .tabItem {
                    Image("history")
                }
            
            StatsView()
                .tabItem {
                    Image("statistics")
                }
            
            Text("Settings")
                .tabItem {
                    Image("settings")
                }
        }
        .toolbarBackground(.thickMaterial, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}


#Preview {
    MainTabView()
}
