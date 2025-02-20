//
//  Date.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import Foundation

extension Date {
    private var timeForrmatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "HH/dd/yy"
        return formatter
    }
    
    private func timeString() -> String {
        timeForrmatter.string(from: self)
    }
    
    private func dataString() -> String {
        dayFormatter.string(from: self)
    }
    
    func timestampString() -> String {
        if Calendar.current.isDateInToday(self) {
            timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            "Yesturday"
        } else {
            dataString()
        }
    }
}
