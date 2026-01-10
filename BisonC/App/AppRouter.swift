//
//  AppRouter.swift
//  BisonC
//
//  Created by Maksim Kosharny on 10.01.2026.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class AppRouter: ObservableObject {
    
    @Published var homePath = NavigationPath()
    @Published var favoritesPath = NavigationPath()
    @Published var settingsPath = NavigationPath()
    
    enum Route: Hashable {
        case search
        case results(query: String)
        case article(id: String)
        case about
    }
    
    func openArticle(_ id: String, fromFavorites: Bool = false) {
        if fromFavorites {
            favoritesPath.append(Route.article(id: id))
        } else {
            homePath.append(Route.article(id: id))
        }
    }
}
