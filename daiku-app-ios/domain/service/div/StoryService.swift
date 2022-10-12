//
//  StoryService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/05.
//

import Foundation

enum StoryService: ApiService {
    case createStory(StoryCreateRequest)
    case updateBody(StoryBodyUpdateRequest)
    
}

extension StoryService {
    
    var requestType: RequestType {
        switch self {
        case let .createStory(encodable):
            return .requestBodyToJson(body: encodable)
        case let .updateBody(encodable):
            return .requestBodyToJson(body: encodable)
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
        case .createStory, .updateBody:
            return .POST
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .createStory:
            return "/api/story/create"
        case .updateBody:
            return "/api/story/update-story-body"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .createStory:
            return StoryResponse.self as! Codable
        case .updateBody:
            return IdeaSearchResponse.self as! Codable
        }
    }
    
}
