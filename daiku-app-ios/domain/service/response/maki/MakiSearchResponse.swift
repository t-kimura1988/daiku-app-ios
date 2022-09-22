//
//  MakiSearchResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/15.
//

import Foundation

struct MakiSearchResponse: Decodable, Identifiable {
    var id: Int = 0
    var accountId: Int = 0
    var createdAccountFamilyName: String = ""
    var createdAccountGivenName: String = ""
    var createdAccountImg: String? = ""
    var makiTitle: String = ""
    var makiKey: String = ""
    var makiDesc: String = ""
    
    func getAccountImageURL() -> String {
        guard let createdAccountImg = createdAccountImg else {
            return ""
        }
        
        return createdAccountImg
    }
}
