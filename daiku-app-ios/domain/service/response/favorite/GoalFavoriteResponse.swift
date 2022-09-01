//
//  GoalFavoriteResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/15.
//

import Foundation

struct GoalFavoriteResponse: Decodable, Identifiable {
    var id: Int = 0
    var goalId: Int = 0
    var accountId: Int = 0
    var favoriteAddDate: String = ""
    var goalCreateDate: String = ""
    var goalCreatedAccountFamilyName: String = ""
    var goalCreatedAccountGivenName: String = ""
    var goalCreatedAccountNickName: String = ""
    var goalCreatedAccountImg: String? = ""
    var title: String = ""
    var purpose: String = ""
    var dueDate: String = ""
    var favoriteAddAccountFamilyName: String = ""
    var favoriteAddAccountGivenName: String = ""
    var favoriteAddAccountNickName: String = ""
    var favoriteAddAccountImg: String? = ""
    var archiveId: Int? = 0
    var archivesCreateDate: String? = ""
    
    private func toDate(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date)!
    }
    
    func getArchiveId() -> Int {
        if let archiveId = archiveId {
            return archiveId
        }
        
        return 0
    }
    
    func getArchiveCreateDate() -> String {
        if let archiveCreateDate = archivesCreateDate {
            return archiveCreateDate
        }
        
        return ""
    }

    func dueDateFormat() -> String {
        let date = toDate(date: dueDate)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"

        return formatter.string(from: date)

    }
    
    func favoriteAddDateFormat() -> String {
        let date = toDate(date: favoriteAddDate)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"

        return formatter.string(from: date)
        
    }
    
    func goalCreateAccount() -> String {
        return goalCreatedAccountFamilyName + " " + goalCreatedAccountGivenName + "(" + goalCreatedAccountNickName + ")"
    }
}
