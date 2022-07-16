//
//  ProcessHistoryCommentRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/10.
//

import Foundation

struct ProcessHisotryCommentRequest: Encodable {
    var processId: Int
    var comment: String
    var processStatus: String
    var priority: String
}
