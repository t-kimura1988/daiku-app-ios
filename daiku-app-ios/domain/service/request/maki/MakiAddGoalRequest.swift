//
//  MakiAddGoalRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/18.
//

import Foundation


struct MakiAddGoalRequest: Encodable, Hashable {
    var makiId: String
    var goalId: String
    var goalCreateDate: String
}
