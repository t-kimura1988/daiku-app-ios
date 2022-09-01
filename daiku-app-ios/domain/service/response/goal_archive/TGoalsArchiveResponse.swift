//
//  TGoalsArchiveResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/20.
//

import Foundation

struct TGoalsArchiveResponse: Decodable, Identifiable {
    var id: Int = 0
    var archivesCreateDate: String = ""
    var goalId: Int = 0
    var thoughts: String = ""
    var updatingFlg: String = ""
    var publish: String = ""
    var createBy: Int? = 0
    var createdAt: String? = ""
    var updatedAt: String? = ""
    var updatedBy: Int? = 0
}
