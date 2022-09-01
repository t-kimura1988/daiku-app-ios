//
//  Goal.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/02.
//

import Foundation

struct GoalResponse: Decodable, Identifiable {
    var id: Int = 0
    var createDate: String = ""
    var accountId: Int = 0
    var createdAccountFamilyName: String = ""
    var createdAccountGivenName: String = ""
    var createdAccountImg: String? = ""
    var title: String = ""
    var purpose: String = ""
    var aim: String = ""
    var dueDate: String = ""
    var favoriteId: Int? = 0
    var updatingFlg: String? = ""
    var archiveId: Int? = 0
    var archivesCreateDate: String? = ""
    
    func isFavorite() -> Bool {
        
        return favoriteId != nil
    }
    
    func isArchive() -> Bool {
        if let _ = archiveId {
            return true
        }
        
        return false
    }
    
    func getArchiveId() -> Int{
        if let archiveId = archiveId {
            return archiveId
        }
        
        return 0
    }
    
    func getArchiveCreateDate()->String {
        if let archiveCreateDate = archivesCreateDate {
            return archiveCreateDate
        }
        
        return ""
    }
    
    func editable() -> Bool {
        if let updatingFlg = updatingFlg {
            return updatingFlg == "1"
        }
        return true
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
    
    func accountName() -> String {
        return createdAccountFamilyName + " " + createdAccountGivenName
    }
}
