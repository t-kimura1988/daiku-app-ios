//
//  MakiService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/14.
//

import Foundation

enum MakiService: ApiService {
    
    case create(MakiCreateRequest)
    case search(MyMakiListParameter)
    case myDetail(MyMakiDetailParameter)
    case makiGoalList(MakiGoalListParameter)
    case makiAddGoalList(MakiAddGoalListParameter)
    case makiAddGoal([MakiAddGoalRequest])
}

extension MakiService {
    var requestType: RequestType {
        switch self {
        case .create(let request):
            return .requestBodyToJson(body: request)
        case .search(let param):
            return .requestParametes(parameters: param.params())
        case .myDetail(let param):
            return .requestParametes(parameters: param.params())
        case .makiGoalList(let param):
            return .requestParametes(parameters: param.params())
        case .makiAddGoalList(let param):
            return .requestParametes(parameters: param.params())
        case .makiAddGoal(let body):
            return .requestBodyToJson(body: body)
        }
    }
    
    var baseURL: String {
        let baseApi = Env["BASE_API"]
        
        guard let baseApi = baseApi else {
            return "http://localhost"
        }
        
        return baseApi
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .create, .makiAddGoal:
            return .POST
        case .search, .myDetail, .makiGoalList, .makiAddGoalList:
            return .GET
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .create:
            return "/api/maki/create"
        case .search:
            return "/api/maki/search"
        case .myDetail:
            return "/api/maki/detail"
        case .makiGoalList:
            return "/api/maki/goal-list"
        case .makiAddGoalList:
            return "/api/maki/add/goal-list"
        case .makiAddGoal:
            return "/api/maki/add/goal"
        }
    }
    
    var responseType: Decodable? {
        switch self {
        case .create:
            return TMakiResponse.self as! Codable
        case .search, .myDetail:
            return MakiSearchResponse.self as! Codable
        case .makiGoalList:
            return GoalResponse.self as! Codable
        case .makiAddGoalList, .makiAddGoal:
            return MakiAddGoalItem.self as! Codable
        }
    }
    
}
