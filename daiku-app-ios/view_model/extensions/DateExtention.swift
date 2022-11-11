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
    
    func getDaysForMonth() -> [Date] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: self),
              let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.end) else {
            return []
        }
        
        let resultDates = Calendar.current.generateDates(inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end), matching: DateComponents(hour: 0, minute: 0, second: 0))
        
        return resultDates
    }
}

extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates = [interval.start]
                enumerateDates(startingAfter: interval.start,
                               matching: components,
                               matchingPolicy: .nextTime
                ) { date, _, stop in
                    if let date = date {
                        if date < interval.end {
                            dates.append(date)
                        } else {
                            stop = true
                        }
                    }
                }
                return dates
    }
}
