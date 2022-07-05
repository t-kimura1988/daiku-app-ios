//
//  GoalArchiveRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/29.
//

import Foundation
struct GoalArchiveRequest {
    var year: String
    var pageCount: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "year", value: year),
            URLQueryItem(name: "pageCount", value: pageCount)
        ]
        
        return queryItems
    }
}
