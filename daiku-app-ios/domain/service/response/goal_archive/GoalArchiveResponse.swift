//
//  GoalArchiveResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/16.
//

import Foundation


struct GoalArchiveResponse: Decodable {
    
    var goalArchiveInfo: HomeResponse = HomeResponse()
    
    var goalInfo: GoalResponse = GoalResponse()
    
    var processInfo: [ProcessResponse]? = [ProcessResponse]()
    
    func getProcessList() -> [ProcessResponse] {
        if let processInfo = processInfo {
            return processInfo
        }
        
        return [ProcessResponse]()
    }
}
