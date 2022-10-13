//
//  myIdeaList.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/03.
//

import Foundation

struct MyIdeaListParameter {
    var page: String
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "page", value: page)
        ]
        
        return queryItems
    }
}
