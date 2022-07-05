//
//  MyGoalResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/04.
//

import Foundation

struct MyGoalResponse: Decodable, Identifiable {
    var id: Int = 0
    var title: String = ""
    var purpose: String = ""
    var aim: String = ""
}
