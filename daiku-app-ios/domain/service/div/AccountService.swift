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
    case updateAccount(AccountCreateRequest)
    case deleteAccount
    case reUpdateAccount
    case uploadImage(AccountUploadImageRequest)
}

extension AccountService {
    var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_API") as! String
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .existAccount:
            return .GET
        case .createAccount, .updateAccount, .deleteAccount, .reUpdateAccount, .uploadImage:
            return .POST
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var responseType: Decodable? {
        switch self {
        case .existAccount, .createAccount, .updateAccount, .deleteAccount, .reUpdateAccount, .uploadImage:
            return AccountResponse.self as! Codable
        }
    }
    
    var path: String {
        switch self {
        case .existAccount:
            return "/api/account/show"
        case .createAccount:
            return "/api/account/create"
        case .updateAccount:
            return "/api/account/update"
        case .deleteAccount:
            return "/api/account/delete"
        case .reUpdateAccount:
            return "/api/account/re-update"
        case .uploadImage:
            return "/api/account/upload"
        }
    }
    
    var requestType: RequestType{
        switch self {
        case .existAccount:
               return .requestParametes(parameters: [])
        case let .createAccount(encodable):
            return .requestBodyToJson(body: encodable)
        case let .updateAccount(request):
            return .requestBodyToJson(body: request)
        case .deleteAccount:
            return .request
        case .reUpdateAccount:
            return .request
        case let .uploadImage(request):
            return .requestBodyToJson(body: request)
        }
    }
}
