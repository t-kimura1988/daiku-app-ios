//
//  GoalArchiveRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/29.
//

import Foundation
struct GoalArchiveRequest {
    var year: String
    var month: String
    var pageCount: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "year", value: year),
            URLQueryItem(name: "page", value: pageCount),
            URLQueryItem(name: "month", value: month)
        ]
        
        return queryItems
    }
}
