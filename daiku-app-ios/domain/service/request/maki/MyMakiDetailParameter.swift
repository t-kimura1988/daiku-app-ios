//
//  MyMakiDetailParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/15.
//

import Foundation

struct MyMakiDetailParameter {
    var makiId: String
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "makiId", value: makiId)
        ]
        
        return queryItems
    }
}
