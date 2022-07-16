//
//  GoalFavoriteService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/04.
//

import Foundation

enum GoalFavoriteService: ApiService {
    case changeGoalFavorite(GoalFavoriteCreateRequest)
    case favoriteGoalSearch(GoalFavoriteSearchParameter)
}

extension GoalFavoriteService {
    
    var requestType: RequestType {
        switch self {
        case .changeGoalFavorite(let request):
            return .requestBodyToJson(body: request)
        case .favoriteGoalSearch(let parameter):
            return .requestParametes(parameters: parameter.params())
        }
    }
    var baseURL: String {
        return "http://127.0.0.1:8080"
    }
    var httpMethod: HttpMethod {
        switch self {
        case .changeGoalFavorite:
            return .POST
        case .favoriteGoalSearch:
            return .GET
        }
    }
    var isAuth: Bool {
        return true
    }
    var path: String {
        switch self {
        case .changeGoalFavorite:
            return "/api/goal-favorite/change"
        case .favoriteGoalSearch:
            return "/api/goal-favorite/search"
            
        }
    }
    var responseType: Decodable? {
        switch self {
        case .changeGoalFavorite:
            return nil
        case .favoriteGoalSearch:
            return GoalFavoriteResponse.self as! Codable
        }
    }
}
