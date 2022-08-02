//
//  GoalArchiveService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/17.
//

import Foundation

enum GoalArchiveService: ApiService {
    case detail(GoalArchiveDetailParameter)
    case create(GoalArchiveCreateRequest)
    case update(GoalArchiveUpdateRequest)
    case updatingFlg(GoalArchiveUpdatingFlgEditRequest)
}

extension GoalArchiveService {
    var requestType: RequestType {
        switch self {
        case .detail(let parameter):
            return .requestParametes(parameters: parameter.params())
        case .create(let request):
            return .requestBodyToJson(body: request)
        case .update(let request):
            return .requestBodyToJson(body: request)
        case .updatingFlg(let request):
            return .requestBodyToJson(body: request)
        }
    }
    var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_API") as! String
    }
    var httpMethod: HttpMethod {
        switch self {
        case .detail:
            return .GET
        case .create, .update, .updatingFlg:
            return .POST
        }
    }
    var isAuth: Bool {
        return true
    }
    var path: String {
        switch self {
        case .detail:
            return "/api/goal/archive/detail"
        case .create:
            return "/api/goal/create/archive"
        case .update:
            return "/api/goal/update/archive"
        case .updatingFlg:
            return "/api/goal/update/archive/updating-flg"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .detail:
            return GoalArchiveResponse.self as! Codable
            
        case .create, .update:
            return TGoalsArchiveResponse.self as! Codable
            
        case .updatingFlg:
            return GoalResponse.self as! Codable
        }
    }
    
}
