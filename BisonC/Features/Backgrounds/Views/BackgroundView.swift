//
//  BackgroundView.swift
//  BisonC
//
//  Created by Maksim Kosharny on 08.01.2026.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("appBackground")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
