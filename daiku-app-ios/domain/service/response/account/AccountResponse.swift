//
//  AccountResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/23.
//

import Foundation

struct AccountResponse: Decodable {
    var id: Int = 0
    var uid: String = ""
    var familyName: String = ""
    var givenName: String = ""
    var nickName: String = ""
    var userImage: String? = ""
    var email: String = ""
//    
    func accountName() -> String {
        return "\(familyName)  \(givenName) "
    }
}
