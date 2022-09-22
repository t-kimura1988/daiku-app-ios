//
//  MakiAddGoalResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/19.
//

import Foundation

struct MakiAddGoalResponse: Decodable, Identifiable {
    var id: Int = 0
    var makiId: Int = 0
    var goalId: Int = 0
    var goalCreateDate: String = ""
}
