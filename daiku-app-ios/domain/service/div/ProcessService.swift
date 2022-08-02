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
    case updateProcess(ProcessUpdateRequest)
    case updateTerm(ProcessTermRequest)
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
        case .updateProcess(let body):
            return .requestBodyToJson(body: body)
        case .updateTerm(let body):
            return .requestBodyToJson(body: body)
        }
    }
    var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_API") as! String
    }
    var httpMethod: HttpMethod {
        switch self {
        case .processList, .processDetail:
            return .GET
        case .createProcess, .updateProcess, .updateTerm:
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
        case .updateProcess:
            return "/api/process/update"
        case .updateTerm:
            return "/api/process/update/process-date"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .processList, .processDetail, .updateTerm:
            return ProcessResponse.self as! Codable
        case .createProcess, .updateProcess:
            return TProcessResponse.self as! Codable
        }
    }
    
}
