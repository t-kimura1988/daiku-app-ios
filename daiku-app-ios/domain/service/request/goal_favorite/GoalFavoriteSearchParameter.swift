//
//  GoalFavoriteSearchParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/15.
//

import Foundation


struct GoalFavoriteSearchParameter {
    var year: String
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "year", value: year)
        ]
        
        return queryItems
    }
}
