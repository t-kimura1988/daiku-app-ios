//
//  StoryBodyUpdateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/10.
//

import Foundation

struct StoryBodyUpdateRequest: Encodable {
    var storyId: String
    var ideaId: String
    var storyBody: String
}
