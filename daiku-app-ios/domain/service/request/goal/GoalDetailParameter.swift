//
//  GoalDetailParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import Foundation

struct GoalDetailParameter {
    var goalId: Int
    var createDate: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "goalId", value: String(goalId)),
            URLQueryItem(name: "createDate", value: createDate)
        ]
        
        return queryItems
    }
}
