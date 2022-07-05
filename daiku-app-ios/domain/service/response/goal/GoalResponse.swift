//
//  Goal.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/02.
//

import Foundation

struct GoalResponse: Decodable, Identifiable {
    var id: Int = 0
    var title: String = ""
    var purpose: String = ""
    var aim: String = ""
    var dueDate: String = ""
    var favoriteId: Int? = 0
    var createDate: String = ""
    
    func isFavorite() -> Bool {
        
        return favoriteId != nil
    }
    
    private func dueDateToDate() -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dueDate)!
    }
    
    func dueDateFormat() -> String {
        let date = dueDateToDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        
        return formatter.string(from: date)
        
    }
}
