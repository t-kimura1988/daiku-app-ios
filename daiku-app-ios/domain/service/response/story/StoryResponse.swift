//
//  StoryResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/05.
//

import Foundation

struct StoryResponse: Decodable, Identifiable, Hashable {
    var id: Int = 0
    var ideaId: Int = 0
    var title: String = ""
}
