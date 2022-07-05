//
//  AccountCreateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/28.
//

import Foundation

struct AccountCreateRequest: Encodable {
    var familyName: String
    var givenName: String
    var nickName: String
}
