//
//  HomeService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/29.
//

import Foundation

enum HomeService: ApiService {
    
    case getArchiveGoal(GoalArchiveRequest)
    
}

extension HomeService {
    var requestType: RequestType {
        switch self {
        case let .getArchiveGoal(goalArchiveRequest):
            return .requestParametes(parameters: goalArchiveRequest.params())
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
        case .getArchiveGoal:
            return .GET
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .getArchiveGoal:
            return "/api/goal/archive/search"
        }
    }
    
    var responseType: Decodable? {
        switch self {
        case .getArchiveGoal:
            return HomeResponse.self as! Codable
        }
    }
    
    
}
