//
//  AccountUpdateRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/24.
//

import Foundation

struct AccountUpdateRequest: Encodable {
    var familyName: String
    var givenName: String
    var nickName: String
}
