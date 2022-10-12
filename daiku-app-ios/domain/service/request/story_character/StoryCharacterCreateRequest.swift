//
//  StoryCharacterCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/09.
//

import Foundation

struct StoryCharacterCreateRequest: Encodable {
    var ideaId: Int
    var storyId: Int
    var charaName: String
    var charaDesc: String
    var leaderFlg: String
}
