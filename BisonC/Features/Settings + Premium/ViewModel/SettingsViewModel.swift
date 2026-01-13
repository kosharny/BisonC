//
//  SettingsViewModel.swift
//  BisonC
//
//  Created by Maksim Kosharny on 13.01.2026.
//

import Foundation
import Combine
import SwiftUI

enum AppTheme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
}

enum AppTextSize: String, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    
    var fontSizeMultiplier: Double {
        switch self {
        case .small: return 0.85
        case .medium: return 1.0
        case .large: return 1.2
        }
    }
}

@MainActor
final class SettingsViewModel: ObservableObject {
    @AppStorage("app_theme") var theme: AppTheme = .system
    @AppStorage("app_text_size") var textSize: AppTextSize = .medium {
        didSet {
            SettingsViewModel.globalSizeMultiplier = textSize.fontSizeMultiplier
        }
    }
    
    static var globalSizeMultiplier: CGFloat = {
            let savedValue = UserDefaults.standard.string(forKey: "app_text_size") ?? "medium"
            switch savedValue {
            case "small": return 0.85
            case "large": return 1.2
            default: return 1.0
            }
        }()
    
    fileprivate var fontSizeMultiplier: CGFloat {
            switch textSize {
            case .small: return 0.85
            case .medium: return 1.0
            case .large: return 1.2
            }
        }
    
    
    func applyTheme() {
        let style: UIUserInterfaceStyle
        switch theme {
        case .light: style = .light
        case .dark: style = .dark
        case .system: style = .unspecified
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = style
            }
        }
    }
}
