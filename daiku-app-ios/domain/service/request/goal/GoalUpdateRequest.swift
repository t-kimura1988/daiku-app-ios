//
//  GoalUpdateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/19.
//

import Foundation


struct GoalUpdateRequest: Encodable {
    var goalId: Int
    var createDate: String
    var title: String
    var purpose: String
    var aim: String
    var dueDate: String
}
