//
//  GoalArchiveUpdateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/20.
//

import Foundation

struct GoalArchiveUpdateRequest: Encodable {
    var archiveId: Int
    var archiveCreateDate: String
    var thoughts: String
    var publish: String
}
