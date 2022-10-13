//
//  StoryCharacterListParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/09.
//

import Foundation

struct StoryCharacterListParameter {
    
    var ideaId: Int
    var storyId: Int
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "ideaId", value: String(ideaId)),
            URLQueryItem(name: "storyId", value: String(storyId))
        ]
        
        return queryItems
    }
}
