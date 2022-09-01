//
//  ProcessDetailParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import Foundation

struct ProcessDetailParameter {
    var processId: Int
    var goalCreateDate: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "processId", value: String(processId)),
            URLQueryItem(name: "goalCreateDate", value: goalCreateDate)
        ]
        
        return queryItems
    }
}
