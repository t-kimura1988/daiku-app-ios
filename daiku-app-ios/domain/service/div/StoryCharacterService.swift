//
//  StoryCharacterService.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/09.
//

import Foundation

enum StoryCharacterService: ApiService {
    case createStoryCharacter(StoryCharacterCreateRequest)
    case list(StoryCharacterListParameter)
}

extension StoryCharacterService {
    var requestType: RequestType {
        switch self {
        case let .createStoryCharacter(encodable):
            return .requestBodyToJson(body: encodable)
        case let .list(param):
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
        case .createStoryCharacter:
            return .POST
        case .list:
            return .GET
        }
    }
    
    var isAuth: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .createStoryCharacter:
            return "/api/story-character/create"
        case .list:
            return "/api/story-character/list"
        }
    }
    var responseType: Decodable? {
        switch self {
        case .createStoryCharacter, .list:
            return StoryCharacterResponse.self as! Codable
        }
    }
}
