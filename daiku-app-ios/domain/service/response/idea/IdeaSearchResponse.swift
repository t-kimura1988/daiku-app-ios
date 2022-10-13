//
//  IdeaSearchResponse.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/02.
//

import Foundation

struct IdeaSearchResponse: Decodable, Identifiable, Hashable {
    var id: Int = 0
    var accountId: Int = 0
    var createdAccountFamilyName: String = ""
    var createdAccountGivenName: String = ""
    var createdAccountImg: String? = ""
    var body: String = ""
    var storyId: Int? = 0
    var title: String? = ""
    var storyBody: String? = ""
    
    func isStory() -> Bool {
        if let storyId = storyId {
            return storyId != 0
        }
        return false
    }
    
    func getAccountImageURL() -> String {
        guard let createdAccountImg = createdAccountImg else {
            return ""
        }
        
        return createdAccountImg
    }
    func getStoryId() -> Int{
        if let storyId = storyId {
            return storyId
        }
        
        return 0
    }
    func getTitle() -> String {
        if let title = title {
            return title
        }
        return ""
    }
    
    func getStoryBody() -> String {
        if let storyBody = storyBody {
            return storyBody
        }
        return ""
        
    }
}
