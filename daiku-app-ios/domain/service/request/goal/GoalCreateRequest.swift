//
//  GoalCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/02.
//

import Foundation


struct GoalCreateRequest: Encodable {
    var title: String
    var purpose: String
    var aim: String
    var dueDate: String
    var makiId: Int
}
