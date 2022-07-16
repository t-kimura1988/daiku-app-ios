//
//  ProcessHistoryResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import Foundation

struct ProcessHistoryResponse: Decodable, Identifiable {
    var id: Int = 0
    var processId: Int = 0
    var accountId: Int = 0
    var goalId: Int = 0
    var goalCreateDate: String = ""
    var createdAccountFamilyName: String = ""
    var createdAccountGivenName: String = ""
    var createdAccountImg: String? = ""
    var title: String? = ""
    var beforeTitle: String? = ""
    var priority: String? = ""
    var beforePriority: String? = ""
    var processStatus: String? = ""
    var beforeProcessStatus: String? = ""
    var processStartDate: String? = ""
    var beforeProcessStartDate: String? = ""
    var processEndDate: String? = ""
    var beforeProcessEndDate: String? = ""
    var comment: String? = ""
    
    
    func getComment() -> String{
        if let comment = self.comment {
            return comment
        }
        
        return ""
    }
    
    
    func processStatusComment() -> String {
        
        if let status = processStatus, let beforeStatus = beforeProcessStatus {
            if status != beforeStatus {
                return "ステータス: \(ProcessStatus.init(rawValue: beforeStatus).title) → \(ProcessStatus.init(rawValue: status).title)"
            }
        }
        
        return ""
    }
    
    func priorityComment() -> String {
        
        if let priority = priority, let beforePriority = beforePriority {
            if priority != beforePriority {
                return "優先順位: \(ProcessPriority.init(rawValue: beforePriority).title) → \(ProcessPriority.init(rawValue: priority).title)"
            }
        }
        
        return ""
        
    }
    
    func titleComment() -> String {
        
        if let current = title, let before = beforeTitle {
            if current != before {
                return "タイトル変更: \(before)"
            }
        }
        
        return ""
        
    }
}
