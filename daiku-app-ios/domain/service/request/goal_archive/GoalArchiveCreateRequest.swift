//
//  GoalArchiveCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/20.
//

import Foundation


struct GoalArchiveCreateRequest: Encodable {
    var goalId: Int
    var createDate: String
    var thoughts: String
    var publish: String
}
