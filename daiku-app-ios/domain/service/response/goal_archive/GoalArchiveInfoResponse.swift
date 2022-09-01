//
//  GoalArchiveInfoResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/08/15.
//

import Foundation

struct GoalArchiveInfoResponse: Decodable, Identifiable {
    var id: Int = 0
    var archivesCreateDate: String = ""
    var publish: String = ""
    var thoughts: String = ""
    var goalId: Int  = 0
    var goalCreateDate: String = ""
    var title: String = ""
    var purpose: String = ""
    var aim: String  = ""
    var dueDate: String = ""
    var familyName: String = ""
    var givenName: String = ""
    var nickName: String = ""
    var userImage: String? = ""
    var processCount: Int = 0
    var updatingFlg: String? = ""
    var goalCreateAccountId: Int = 0
    
    func accountName() -> String{
        return self.familyName + " " + self.givenName
    }
    
    func getPublish() -> PublishLevel {
        return PublishLevel.init(rowValue: publish)
    }
    
    func isUpdating() -> Bool {
        if let updatingFlg = updatingFlg {
            return updatingFlg == "1"
        }
        return false
    }
}
