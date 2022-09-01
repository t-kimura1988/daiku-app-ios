//
//  TProcessResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import Foundation

struct TProcessResponse: Decodable, Identifiable {
    var id: Int = 0
    var goalId: Int = 0
    var accountId: Int = 0
    var goalCreateDate: String = ""
    var title: String = ""
    var body: String = ""
}
