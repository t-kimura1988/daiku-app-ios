//
//  GoalFavoriteCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/04.
//

import Foundation

struct GoalFavoriteCreateRequest: Encodable {
    var goalId: Int
    var goalCreateDate: String
}
