//
//  ProcessHistoryService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import Foundation

enum ProcessHistoryService: ApiService {
    case processHistoryList(ProcessHistoryListParameter)
    case detail(ProcessHistoryDetailParameter)
    case processHisotryComment(ProcessHisotryCommentRequest)
    case updateComment(CommentUpdateRequest)
    case updateStatus(StatusUpdateRequest)
}

extension ProcessHistoryService {
    
    var requestType: RequestType {
        switch self {
        case .processHistoryList(let parameters):
            return .requestParametes(parameters: parameters.params())
        case  .detail(let parameters):
            return .requestParametes(parameters: parameters.params())
        case .processHisotryComment(let request):
            return .requestBodyToJson(body: request)
        case .updateComment(let request):
            return .requestBodyToJson(body: request)
        case .updateStatus(let request):
            return .requestBodyToJson(body: request)
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
        case .processHistoryList, .detail:
            return .GET
        case .processHisotryComment, .updateComment, .updateStatus:
            return .POST
        }
    }
    var isAuth: Bool {
        return true
    }
    var path: String {
        switch self {
        case .processHistoryList:
            return "/api/process-history/list"
        case .detail:
            return "/api/process-history/detail"
        case .processHisotryComment:
            return "/api/process-history/create"
        case .updateComment:
            return "/api/process-history/update/comment"
        case .updateStatus:
            return "/api/process-history/update/status"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .processHistoryList, .detail:
            return ProcessHistoryResponse.self as! Codable
        case .processHisotryComment, .updateComment, .updateStatus:
            return ProcessHistoryResponse.self as! Codable
        }
    }
}
