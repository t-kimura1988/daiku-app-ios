//
//  ProcessService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import Foundation

enum ProcessService: ApiService {
    case processList(ProcessListParameter)
    case processDetail(ProcessDetailParameter)
    case createProcess(ProcessCreateRequest)
}

extension ProcessService {
    var requestType: RequestType {
        switch self {
        case .processList(let parameters):
            return .requestParametes(parameters: parameters.params())
        case .processDetail(let parameters):
            return .requestParametes(parameters: parameters.params())
        case .createProcess(let body):
            return .requestBodyToJson(body: body)
        }
    }
    var baseURL: String {
        return "http://127.0.0.1:8080"
    }
    var httpMethod: HttpMethod {
        switch self {
        case .processList, .processDetail:
            return .GET
        case .createProcess:
            return .POST
        }
    }
    var isAuth: Bool {
        return true
    }
    var path: String {
        switch self {
        case .processList:
            return "/api/process/list"
        case .processDetail:
            return "/api/process/detail"
        case .createProcess:
            return "/api/process/create"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .processList, .processDetail:
            return ProcessResponse.self as! Codable
        case .createProcess:
            return NoBody.self as! Codable
        }
    }
    
}
