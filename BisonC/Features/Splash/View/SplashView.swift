//
//  SplashView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 09.01.2026.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("BisonC")
                    .font(.customPlayfairDisplaySC(.bold, size: 24))
                    .foregroundStyle(.darkTextApp)
                Image("splashLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 100)
                
                
                Spacer()
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(.darkTextApp, lineWidth: 3)
                    .frame(width: 40, height: 40)
                    .rotationEffect(Angle(degrees: rotationAngle))
                    .onAppear {
                        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                            rotationAngle = 360
                        }
                    }
                    .padding(.bottom, 100)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
