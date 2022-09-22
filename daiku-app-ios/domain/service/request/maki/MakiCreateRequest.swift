//
//  MakiCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/14.
//

import Foundation


struct MakiCreateRequest: Encodable {
    var makiTitle: String
    var makiKey: String
    var makiDesc: String
}
