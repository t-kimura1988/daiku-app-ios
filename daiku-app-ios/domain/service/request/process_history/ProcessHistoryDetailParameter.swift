//
//  ProcessHistoryDetailParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/13.
//

import Foundation

struct ProcessHistoryDetailParameter {
    var processHistoryId: Int
    var goalCreateDate: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "processHistoryId", value: String(processHistoryId)),
            URLQueryItem(name: "goalCreateDate", value: goalCreateDate)
        ]
        
        return queryItems
    }
}
