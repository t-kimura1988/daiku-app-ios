//
//  MakiGoalListParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/16.
//

import Foundation

struct MakiGoalListParameter {
    var makiId: String
    var page: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "makiId", value: makiId),
            URLQueryItem(name: "page", value: page)
        ]
        
        return queryItems
    }
}
