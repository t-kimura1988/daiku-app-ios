//
//  StoryCharacterResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/05.
//

import Foundation

struct StoryCharacterResponse: Decodable, Identifiable, Hashable {
    var id: Int = 0
    var ideaId: Int = 0
    var storyId: Int = 0
    var charaName: String = ""
    var charaDesc: String = ""
    var leaderFlg: String = ""
    
    func isLeader() -> Bool {
        return leaderFlg == "1"
    }
}
