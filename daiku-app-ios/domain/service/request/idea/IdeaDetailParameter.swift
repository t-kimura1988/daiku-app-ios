//
//  IdeaDetailParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/03.
//

import Foundation

struct IdeaDetailParameter {
    var ideaId: Int
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "ideaId", value: String(ideaId))
        ]
        
        return queryItems
    }
    
}
