//
//  ProcessHitoryDuringProcessListParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/28.
//

import Foundation



struct DuringProcessListParameter {
    var processHitoryDate: Date
    
    func params() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "processHistoryDate", value: processHitoryDate.toString(format: "yyyy-MM-dd")),
        ]
        
        return queryItems
    }
}
