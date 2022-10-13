//
//  StoryCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/05.
//

import Foundation


struct StoryCreateRequest: Encodable {
    var ideaId: String
    var title: String
}
