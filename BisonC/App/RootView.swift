//
//  RootView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 10.01.2026.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var appState = AppState()
    
    var body: some View {
        ZStack {
            switch appState.state {
            case .splash:
                SplashView()
                
            case .onboarding:
                OnboardingView(
                    onFinish: {
                        appState.finishOnboarding()
                    }
                )
                
            case .main:
                MainTabView()
            }
        }
        .animation(.easeInOut, value: appState.state)
    }
}


#Preview {
    RootView()
}
