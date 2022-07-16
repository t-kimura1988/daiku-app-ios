//
//  StatusUpdateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/14.
//

import Foundation

struct StatusUpdateRequest: Encodable {
    var processId: Int
    var processStatus: String
    var priority: String
}
