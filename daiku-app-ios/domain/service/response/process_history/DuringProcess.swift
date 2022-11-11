//
//  DuringProcess.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/28.
//

import Foundation


struct DuringProcess: Decodable, Identifiable, Equatable {
    var id: String = ""
    var goalId: Int = 0
    var goalCreateDate: String = ""
    var processId: Int = 0
    var processHistoryId: Int = 0
    var createdAccountFamilyName: String = ""
    var createdAccountGivenName: String = ""
    var createdAccountImg: String? = ""
    var goalTitle: String = ""
    var processTitle: String = ""
    var processBody: String = ""
    var processStartDate: String? = ""
    var processEndDate: String? = ""
    var archiveId: Int? = 0
    var archivesCreateDate: String? = ""
    var updatingFlg: String? = ""
    
    
    func getArchiveId() -> Int{
        if let archiveId = archiveId {
            return archiveId
        }
        
        return 0
    }
    
    func getArchiveCreateDate()->String {
        if let archivesCreateDate = archivesCreateDate {
            return archivesCreateDate
        }
        
        return ""
    }
}
