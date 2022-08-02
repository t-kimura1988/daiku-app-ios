//
//  ProcessTermUpdateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/28.
//

import Foundation


struct ProcessTermRequest: Encodable {
    var processId: Int
    var goalId: Int
    var goalCreateDate: String
    var processStartDate: String
    var processEndDate: String
}
