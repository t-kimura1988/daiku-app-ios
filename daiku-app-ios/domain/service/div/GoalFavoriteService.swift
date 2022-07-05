//
//  GoalFavoriteService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/04.
//

import Foundation

enum GoalFavoriteService: ApiService {
    case changeGoalFavorite(GoalFavoriteCreateRequest)
}

extension GoalFavoriteService {
    
    var requestType: RequestType {
        switch self {
        case .changeGoalFavorite(let request):
            return .requestBodyToJson(body: request)
        }
    }
    var baseURL: String {
        return "http://127.0.0.1:8080"
    }
    var httpMethod: HttpMethod {
        switch self {
        case .changeGoalFavorite:
            return .POST
        }
    }
    var isAuth: Bool {
        return true
    }
    var path: String {
        switch self {
        case .changeGoalFavorite:
            return "/api/goal-favorite/change"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .changeGoalFavorite:
            return nil
        }
    }
}
