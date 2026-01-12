//
//  Date+extensions.swift
//  BisonC
//
//  Created by Maksim Kosharny on 12.01.2026.
//

import Foundation

extension Date {
    
    func formattedForHistory() -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        if calendar.isDateInToday(self) {
            formatter.dateFormat = "'Today at' h:mm a"
        } else if calendar.isDateInYesterday(self) {
            formatter.dateFormat = "'Yesterday at' h:mm a"
        } else {
            formatter.dateFormat = "MMMM d, h:mm a"
        }
        
        return formatter.string(from: self)
    }
}

