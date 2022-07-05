//
//  ProcessService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import Foundation

enum ProcessService: ApiService {
    case processList(ProcessListParameter)
}

extension ProcessService {
    var requestType: RequestType {
        switch self {
        case .processList(let parameters):
            return .requestParametes(parameters: parameters.params())
        }
    }
    var baseURL: String {
        return "http://127.0.0.1"
    }
    var httpMethod: HttpMethod {
        switch self {
        case .processList:
            return .GET
        }
    }
    var isAuth: Bool {
        return true
    }
    var path: String {
        switch self {
        case .processList:
            return "/api/process/list"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .processList:
            return ProcessResponse.self as! Codable
        }
    }
    
}
