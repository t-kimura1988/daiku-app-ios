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
    var beforeTitle: String = ""
    var beforePriority: String = ""
    var priority: String = ""
    var beforeProcessStatus: String = ""
    var processStatus: String = ""
    var body: String = ""
    var beforeBody: String = ""
    var beforeProcessStartDate: String = ""
    var processStartDate: String = ""
    var beforeProcessEndDate: String = ""
    var processEndDate: String = ""
}
