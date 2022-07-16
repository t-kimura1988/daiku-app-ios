//
//  CommentUpdateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/13.
//

import Foundation
struct CommentUpdateRequest: Encodable {
    var processHistoryId: Int
    var comment: String
}
