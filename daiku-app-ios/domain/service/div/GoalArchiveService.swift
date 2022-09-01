//
//  GoalArchiveService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/17.
//

import Foundation

enum GoalArchiveService: ApiService {
    case myGoalArchiveList(GoalArchiveRequest)
    case detail(GoalArchiveDetailParameter)
    case myDetail(GoalArchiveDetailParameter)
    case create(GoalArchiveCreateRequest)
    case update(GoalArchiveUpdateRequest)
    case updatingFlg(GoalArchiveUpdatingFlgEditRequest)
    case editDisp(GoalArchiveDetailParameter)
}

extension GoalArchiveService {
    var requestType: RequestType {
        switch self {
        case .myGoalArchiveList(let parameter):
            return .requestParametes(parameters: parameter.params())
        case .detail(let parameter):
            return .requestParametes(parameters: parameter.params())
        case .myDetail(let parameter):
            return .requestParametes(parameters: parameter.params())
        case .create(let request):
            return .requestBodyToJson(body: request)
        case .update(let request):
            return .requestBodyToJson(body: request)
        case .updatingFlg(let request):
            return .requestBodyToJson(body: request)
        case .editDisp(let parameter):
            return .requestParametes(parameters: parameter.params())
        }
    }
    var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_API") as! String
    }
    var httpMethod: HttpMethod {
        switch self {
        case .detail, .myGoalArchiveList, .editDisp, .myDetail:
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
        case .myDetail:
            return "/api/goal/my-archive/detail"
        case .create:
            return "/api/goal/create/archive"
        case .update:
            return "/api/goal/update/archive"
        case .updatingFlg:
            return "/api/goal/update/archive/updating-flg"
        case .myGoalArchiveList:
            return "/api/goal/my-archive/list"
        case .editDisp:
            return "/api/goal/archive/edit-disp"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .myGoalArchiveList:
            return GoalArchiveInfoResponse.self as! Codable
        case .detail, .myDetail:
            return GoalArchiveResponse.self as! Codable
            
        case .create, .update:
            return TGoalsArchiveResponse.self as! Codable
            
        case .updatingFlg:
            return GoalResponse.self as! Codable
        case .editDisp:
            return GoalArchiveInfoResponse.self as! Codable
        }
    }
    
}
