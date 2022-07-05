//
//  MyGoalLlistParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/04.
//

import Foundation


struct MyGoalListParameter {
    var year: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "year", value: year)
        ]
        
        return queryItems
    }
}
