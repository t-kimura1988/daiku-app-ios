//
//  ApiService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/21.
//

import Foundation

enum AccountService: ApiService {
    
    case existAccount
    case createAccount(AccountCreateRequest)
}

extension AccountService {
    var baseURL: String {
        return "http://127.0.0.1:8080"
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .existAccount:
            return .GET
        case .createAccount:
            return .POST
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var responseType: Decodable? {
        switch self {
        case .existAccount, .createAccount:
            return AccountResponse.self as! Codable
        }
    }
    
    var path: String {
        switch self {
        case .existAccount:
            return "/api/account/show"
        case .createAccount:
            return "/api/account/create"
        }
    }
    
    var requestType: RequestType{
        switch self {
        case .existAccount:
               return .requestParametes(parameters: [])
        case let .createAccount(encodable):
            return .requestBodyToJson(body: encodable)
        }
    }
}
