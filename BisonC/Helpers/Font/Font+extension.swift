//
//  Font+extension.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//

import SwiftUI

extension Font {
    static func customPlayfairDisplay(_ weight: PlayfairDisplayWeight, size: CGFloat) -> Font {
        return Font.custom("PlayfairDisplay-\(weight.rawValue)", size: size)
    }
    
    enum PlayfairDisplayWeight: String {
        case bold = "Bold"
        case regular = "Regular"
        case balck = "Black"
    }
    
    static func customPlayfairDisplaySC(_ weight: PlayfairDisplaySCWeight, size: CGFloat) -> Font {
        return Font.custom("PlayfairDisplaySC-\(weight.rawValue)", size: size)
    }
    
    enum PlayfairDisplaySCWeight: String {
        case bold = "Bold"
    }
    
    static func customInriaSans(_ weight: InriaSansWeight, size: CGFloat) -> Font {
        return Font.custom("InriaSans-\(weight.rawValue)", size: size)
    }
    
    enum InriaSansWeight: String {
        case bold = "Bold"
        case regular = "Regular"
        case light = "Light"
    }
}
