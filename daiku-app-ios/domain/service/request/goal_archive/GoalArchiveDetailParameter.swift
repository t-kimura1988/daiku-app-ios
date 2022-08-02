//
//  GoalArchiveDetailParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/17.
//

import Foundation


struct GoalArchiveDetailParameter {
    var archiveId: Int
    var archiveCreateDate: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "archiveId", value: String(archiveId)),
            URLQueryItem(name: "archiveCreateDate", value: archiveCreateDate)
        ]
        
        return queryItems
    }
}
