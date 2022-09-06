//
//  DateExtention.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/27.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String{
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func compareNowAscending() -> Bool {
        return self.compare(Date()) == .orderedAscending
    }
    
    func compareNowSame() -> Bool {
        let now = Date().toString(format: "yyyyMMdd")
        let target = self.toString(format: "yyyyMMdd")
        return now == target
    }
    
    func compareNowDescending() -> Bool {
        return self.compare(Date()) == .orderedDescending
    }
}
