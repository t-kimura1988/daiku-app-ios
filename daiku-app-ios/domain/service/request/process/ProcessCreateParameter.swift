//
//  ProcessCreateParameter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import Foundation



struct ProcessCreateRequest: Encodable {
    var goalId: Int
    var goalCreateDate: String
    var title: String
    var body: String
    var processStatus: String
    var priority: String
}
