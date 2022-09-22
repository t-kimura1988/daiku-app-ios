//
//  StringExtension.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/25.
//

import Foundation

extension String {
    func moreGreater(size: Int) -> Bool{
        
        if self.count > size {
            return true
        }
        
        return false
    }
    
    func toDate() -> Date {
        if self.isEmpty {
            return Date()
        }
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)!
    }
    
    func toFormatter() -> String {
        if self == "" {
            return self
        }
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: self)!
        
        let toStringFormat = DateFormatter()
        toStringFormat.dateFormat = "yyyy年MM月dd日"
        
        return toStringFormat.string(from: date)
    }
    
    func isAlpaNumSym() -> Bool {
        return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
