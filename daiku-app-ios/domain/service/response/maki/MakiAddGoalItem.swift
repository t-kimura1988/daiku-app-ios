//
//  MakiAddGoalItem.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/17.
//

import Foundation

struct MakiAddGoalItem: Decodable, Identifiable, Hashable {
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
    var makiRelationId: Int? = 0
    
    func getAccountImageURL() -> String {
        guard let createdAccountImg = createdAccountImg else {
            return ""
        }
        
        return createdAccountImg
    }
}
