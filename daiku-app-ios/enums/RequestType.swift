//
//  Request.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/20.
//

import Foundation

enum RequestType {
    case requestParametes(parameters: [URLQueryItem])
    case requestBodyToJson(body: Encodable)
    case request
}
