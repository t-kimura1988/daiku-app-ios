//
//  TProcessHistory.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/28.
//

import Foundation


struct TProcessHistoryResponse: Decodable, Identifiable {
    var id: Int = 0
    var processId: Int = 0
    var accountId: Int = 0
    var goalCreateDate: String = ""
    var beforePriority: String? = ""
    var priority: String? = ""
    var beforeProcessStatus: String? = ""
    var processStatus: String? = ""
    var processStartDate: String? = ""
    var beforeProcessStartDate: String? = ""
    var processEndDate: String? = ""
    var beforeProcessEndDate: String? = ""
    var comment: String? = ""
    var beforeTitle: String? = ""
    var beforeBody: String? = ""
    var createdBy: Int? = 0
    var createdAt: String? = ""
    var updatedAt: String? = ""
    var updatedBy: Int? = 0
}
