//
//  GoalService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/02.
//

import Foundation

enum GoalService: ApiService {
    case createGoal(GoalCreateRequest)
    case myGoalList(MyGoalListParameter)
    case goalDetail(GoalDetailParameter)
}

extension GoalService {
    
    var requestType: RequestType {
        switch self {
        case let .createGoal(encodable):
            return .requestBodyToJson(body: encodable)
        case let .myGoalList(parameter):
            return .requestParametes(parameters: parameter.params())
        case let .goalDetail(parameter):
            return .requestParametes(parameters: parameter.params())
        }
    }
    var baseURL: String {
        return "http://127.0.0.1:8080"
    }
    var httpMethod: HttpMethod {
        switch self {
        case .createGoal:
            return .POST
        case .myGoalList , .goalDetail:
            return .GET
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .createGoal:
            return "/api/goal/create"
        case .myGoalList:
            return "/api/goal/search"
        case .goalDetail:
            return "/api/goal/detail"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .createGoal:
            return nil
        case .myGoalList, .goalDetail:
            return GoalResponse.self as! Codable
        }
    }
}
