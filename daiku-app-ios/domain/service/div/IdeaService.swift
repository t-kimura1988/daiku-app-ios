//
//  IdeaService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/02.
//

import Foundation

enum IdeaService: ApiService {
    case createIdea(IdeaCreateRequest)
    case myIdeaList(MyIdeaListParameter)
    case ideaDetail(IdeaDetailParameter)
}

extension IdeaService {
    
    
    var requestType: RequestType {
        switch self {
        case let .createIdea(encodable):
            return .requestBodyToJson(body: encodable)
        case let .myIdeaList(param):
            return .requestParametes(parameters: param.params())
        case let .ideaDetail(param):
            return .requestParametes(parameters: param.params())
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
        case .createIdea:
            return .POST
        case .myIdeaList, .ideaDetail:
            return .GET
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .createIdea:
            return "/api/idea/create"
        case .myIdeaList:
            return "/api/idea/my-search"
        case .ideaDetail:
            return "/api/idea/detail"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .createIdea, .myIdeaList, .ideaDetail:
            return IdeaSearchResponse.self as! Codable
        }
    }
}
