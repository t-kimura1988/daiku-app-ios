//
//  IdeaCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/02.
//

import Foundation

struct IdeaUpdateRequest: Encodable {
    var ideaId: Int
    var body: String
}
