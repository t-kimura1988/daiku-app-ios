//
//  ProcessResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import Foundation

struct ProcessResponse: Decodable, Identifiable {
    var id: Int = 0
    var goalId: Int = 0
    var accountId: Int = 0
    var goalCreateDate: String = ""
    var createdAccountFamilyName: String = ""
    var createdAccountGivenName: String = ""
    var title: String = ""
    var beforeTitle: String? = ""
    var beforePriority: String? = ""
    var priority: String = ""
    var beforeProcessStatus: String? = ""
    var processStatus: String = ""
    var body: String = ""
    var beforeBody: String? = ""
    var beforeProcessStartDate: String? = ""
    var processStartDate: String? = ""
    var beforeProcessEndDate: String? = ""
    var processEndDate: String? = ""
    
    func statusToEnum() -> ProcessStatus {
        
        return ProcessStatus.init(rawValue: processStatus)
    }
    
    func priorityToEnum() -> ProcessPriority {
        return ProcessPriority.init(rawValue: priority)
    }
    
    func startDisp() -> String {
        if let processStartDate = processStartDate {
            return processStartDate.toFormatter()
        }
        
        return Date().toString(format: "yyyy年MM月dd日")
    }
    
    func endDisp() -> String {
        if let processEndDate = processEndDate {
            return processEndDate.toFormatter()
        }
        
        return Date().toString(format: "yyyy年MM月dd日")
    }
    
    func start() -> Date {
        if let processStartDate = processStartDate {
            return processStartDate.toDate()
        }
        
        return Date()
    }
    
    func end() -> Date {
        if let processEndDate = processEndDate {
            return processEndDate.toDate()
        }
        
        return Date()
    }
}


