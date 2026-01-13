//
//  CustomAlertCard.swift
//  BisonC
//
//  Created by Maksim Kosharny on 13.01.2026.
//

import Foundation
import SwiftUI

enum AlertType {
    case success
    case error
    case confirmation
}

struct AlertData {
    let type: AlertType
    let title: String
    let message: String
    let primaryButtonTitle: String
}

struct CustomAlertCard: View {
    let data: AlertData
    var onAction: () -> Void
    var onCancel: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(iconColor)
                    .frame(width: 44, height: 44)
                
                Image(systemName: iconName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.beigeApp)
            }
            .padding(.top, 10)

            VStack(spacing: 8) {
                Text(data.title)
                    .font(.customInriaSans(.bold, size: 18))
                    .foregroundStyle(Color.darkTextApp)
                
                Text(data.message)
                    .font(.customInriaSans(.regular, size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.darkTextApp)
                    .padding(.horizontal, 10)
            }

            // Кнопки
            HStack(spacing: 15) {
                if data.type == .confirmation {
                    Button(action: { onCancel?() }) {
                        Text("Cancel")
                            .font(.customInriaSans(.bold, size: 16))
                            .foregroundStyle(.brownApp)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 12).stroke(Color(red: 0.55, green: 0.4, blue: 0.3), lineWidth: 1))
                    }
                }

                Button(action: { onAction() }) {
                    Text(data.primaryButtonTitle)
                        .font(.customInriaSans(.bold, size: 16))
                        .foregroundStyle(.beigeApp)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(buttonColor)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 10)
        }
        .padding(25)
        .background(Color.beigeApp)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.2), radius: 20)
        .padding(.horizontal, 40)
    }

    private var iconName: String {
        switch data.type {
        case .success: return "checkmark"
        case .error: return "xmark"
        case .confirmation: return "questionmark"
        }
    }

    private var iconColor: Color {
        switch data.type {
        case .success: return Color(red: 0.46, green: 0.75, blue: 0.56)
        case .error: return Color(red: 0.85, green: 0.33, blue: 0.31)
        case .confirmation: return Color.orange
        }
    }

    private var buttonColor: Color {
        switch data.type {
        case .confirmation: return Color(red: 0.93, green: 0.5, blue: 0.4)
        default: return Color(red: 0.55, green: 0.4, blue: 0.3)
        }
    }
}

#Preview {
    CustomAlertCard(data: AlertData(type: .error, title: "Purchase Successful!", message: "You have successfully unlocked the 'Export Data' feature. You can now export your reading history.", primaryButtonTitle: "OK"), onAction: {}, onCancel: {})
}
