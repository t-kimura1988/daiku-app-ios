//
//  ProcessHistoryListParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import Foundation

struct ProcessHistoryListParameter {
    var processId: Int
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "processId", value: String(processId)),
        ]
        
        return queryItems
    }
}
