//
//  ApiErrorResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/26.
//

import Foundation

struct ApiErrorResponse: Decodable, Error {
    var code: Int = 0
    var message: String = ""
    var errorCd: String? = ""
}
